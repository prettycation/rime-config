#!/usr/bin/env python3
"""Download and verify the theme's font files for release packaging.

Python 3.10+, standard library only. Branches/tags are resolved to a commit
before raw downloads. Git blobs and published release SHA-256 digests are
verified. Cached objects are rechecked, and font errors fail the build.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import struct
import sys
import tempfile
import time
from urllib.error import HTTPError, URLError
from urllib.parse import quote, urlparse
from urllib.request import Request, urlopen
import zipfile

FONT_SUFFIXES = {".ttf", ".otf", ".ttc", ".otc", ".woff", ".woff2"}
NOTICE_RE = re.compile(r"^(?:licen[sc]e|ofl|copying|notice|copyright|authors|credits)(?:[._-].*)?$", re.I)
MAX_DOWNLOAD = 1024 * 1024 * 1024


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def git_sha(data: bytes) -> str:
    return hashlib.sha1(b"blob " + str(len(data)).encode() + b"\0" + data).hexdigest()


def write_json(path: Path, value: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temp = path.with_name(path.name + ".tmp")
    temp.write_text(json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    temp.replace(path)


def safe_relative(path: str) -> PurePosixPath:
    value = PurePosixPath(path)
    if not path or value.is_absolute() or ".." in value.parts or "\\" in path:
        raise ValueError(f"Unsafe relative path: {path!r}")
    return value


def font_metadata(data: bytes) -> dict:
    """Validate the sfnt container and preserve copyright/license name records."""
    if len(data) < 12 or data[:4] not in (b"\0\1\0\0", b"OTTO", b"true"):
        raise ValueError("Not a supported TTF/OTF font (possibly HTML or an LFS pointer)")
    count = struct.unpack_from(">H", data, 4)[0]
    if not 1 <= count <= 4096 or 12 + count * 16 > len(data):
        raise ValueError("Invalid font table directory")
    tables = {}
    for i in range(count):
        tag, _, offset, size = struct.unpack_from(">4sIII", data, 12 + i * 16)
        if offset + size > len(data):
            raise ValueError(f"Truncated font table {tag!r}")
        tables[tag] = (offset, size)
    if not {b"head", b"maxp", b"cmap", b"name"}.issubset(tables):
        raise ValueError("Font is missing required tables")
    start, size = tables[b"name"]
    block = data[start:start + size]
    if len(block) < 6:
        raise ValueError("Truncated font name table")
    _, names_count, strings_start = struct.unpack_from(">HHH", block, 0)
    if 6 + 12 * names_count > len(block):
        raise ValueError("Truncated font name records")
    fields = {0: "copyright", 1: "family", 5: "version", 8: "manufacturer",
              9: "designer", 11: "vendor_url", 13: "license", 14: "license_url"}
    result: dict[str, list[str]] = {}
    for i in range(names_count):
        platform, _, _, name_id, length, offset = struct.unpack_from(">HHHHHH", block, 6 + i * 12)
        if name_id not in fields:
            continue
        end = strings_start + offset + length
        if end > len(block):
            raise ValueError("Truncated font name string")
        raw = block[strings_start + offset:end]
        text = raw.decode("utf-16-be" if platform in (0, 3) else "mac_roman", errors="replace")
        values = result.setdefault(fields[name_id], [])
        if text and text not in values:
            values.append(text)
    return result


def referenced_fonts(theme: Path) -> set[str]:
    text = theme.read_text(encoding="utf-8")
    text = re.sub(r"--\[\[.*?\]\]", "", text, flags=re.S)
    text = re.sub(r"--[^\n]*", "", text)
    blocks = re.findall(r"\bfont_list\s*=\s*\{(.*?)\}", text, flags=re.S)
    names = set()
    for block in blocks:
        names.update(re.findall(r'''["']([^"'\r\n]+\.(?:ttf|otf|ttc|otc|woff2?))["']''', block, re.I))
    if not names:
        raise ValueError(f"No font_list found in {theme}")
    return names


def pick_entry(entries: list[dict], spec: dict) -> dict:
    name = spec["name"]
    path = spec.get("path")
    matches = [e for e in entries if e.get("type") == "blob" and
               (e["path"] == path if path else PurePosixPath(e["path"]).name == name)]
    if len(matches) != 1:
        paths = [e["path"] for e in matches]
        raise ValueError(f"Expected exactly one {path or name}; found {paths}")
    return matches[0]


class Network:
    def __init__(self, cache: Path):
        self.cache = cache
        self.cache.mkdir(parents=True, exist_ok=True)
        self.used: set[Path] = set()

    def request(self, url: str, *, api: bool = False) -> bytes:
        parsed = urlparse(url)
        if parsed.scheme != "https":
            raise ValueError("Only HTTPS download URLs are allowed")
        headers = {"User-Agent": "rime-config-font-ci", "Accept": "application/vnd.github+json" if api else "*/*"}
        # Authentication is limited to GitHub API requests.
        if api and parsed.hostname == "api.github.com":
            headers["X-GitHub-Api-Version"] = "2022-11-28"
            token = os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN")
            if token:
                headers["Authorization"] = f"Bearer {token}"
        for attempt in range(4):
            try:
                with urlopen(Request(url, headers=headers), timeout=120) as response:
                    chunks, total = [], 0
                    while chunk := response.read(1024 * 1024):
                        total += len(chunk)
                        if total > MAX_DOWNLOAD:
                            raise ValueError(f"Download is too large: {url}")
                        chunks.append(chunk)
                    data = b"".join(chunks)
                    expected_length = response.headers.get("Content-Length")
                    if expected_length and int(expected_length) != total:
                        raise ValueError(f"Incomplete HTTP response: {url}")
                    if not data:
                        raise ValueError(f"Empty HTTP response: {url}")
                    return data
            except (HTTPError, URLError, TimeoutError, OSError) as exc:
                if isinstance(exc, HTTPError) and exc.code not in (403, 408, 429, 500, 502, 503, 504):
                    raise
                if attempt == 3:
                    raise
                time.sleep(2 ** attempt)
        raise RuntimeError("Unreachable")

    def api(self, path: str) -> dict:
        value = json.loads(self.request("https://api.github.com/" + path, api=True))
        if not isinstance(value, dict) or ("message" in value and "sha" not in value and "assets" not in value):
            raise ValueError(f"Unexpected GitHub response for {path}: {value}")
        return value

    def download(self, url: str, identity: str, *, blob_sha: str = "", digest: str = "") -> bytes:
        key = sha256(identity.encode())
        dest = self.cache / (key + ".bin")
        sidecar = self.cache / (key + ".json")
        self.used.update((dest, sidecar))

        def valid(data: bytes, local_sha: str = "") -> bool:
            if not data or (local_sha and sha256(data) != local_sha):
                return False
            if blob_sha and git_sha(data) != blob_sha:
                return False
            if digest and sha256(data) != digest.removeprefix("sha256:"):
                return False
            return True

        if dest.exists() and sidecar.exists():
            try:
                data = dest.read_bytes()
                local_sha = json.loads(sidecar.read_text())["sha256"]
                if valid(data, local_sha):
                    return data
            except (ValueError, KeyError, OSError):
                pass
        data = self.request(url)
        if not valid(data):
            raise ValueError(f"Checksum mismatch: {url}")
        temp = dest.with_suffix(".part")
        temp.write_bytes(data)
        temp.replace(dest)
        write_json(sidecar, {"url": url, "sha256": sha256(data)})
        return data

    def prune(self) -> None:
        for file in self.cache.iterdir():
            if file.is_file() and file not in self.used:
                file.unlink()


def raw_file(net: Network, repo: str, commit: str, entry: dict) -> tuple[bytes, str]:
    path = quote(entry["path"], safe="/")
    url = f"https://raw.githubusercontent.com/{repo}/{commit}/{path}"
    data = net.download(url, "git:" + entry["sha"], blob_sha=entry["sha"])
    if data.startswith(b"version https://git-lfs.github.com/spec/v1"):
        match = re.search(rb"oid sha256:([0-9a-f]{64})", data)
        if not match:
            raise ValueError("Invalid Git LFS pointer")
        digest = match[1].decode()
        url = f"https://media.githubusercontent.com/media/{repo}/{commit}/{path}"
        data = net.download(url, "lfs:" + digest, digest=digest)
    return data, url


def archive_member(data: bytes, name: str) -> tuple[bytes, str]:
    with zipfile.ZipFile(__import__("io").BytesIO(data)) as archive:
        matches = [e for e in archive.infolist() if not e.is_dir() and PurePosixPath(e.filename).name == name]
        if len(matches) != 1:
            raise ValueError(f"Archive must contain exactly one {name}; found {len(matches)}")
        entry = matches[0]
        safe_relative(entry.filename)
        if entry.file_size > MAX_DOWNLOAD:
            raise ValueError(f"Oversized archive member: {entry.filename}")
        # Read the selected archive member without extracting archive paths.
        return archive.read(entry), entry.filename


def build_source(net: Network, source: dict, stage: Path) -> dict:
    repo, requested = source["repository"], source["ref"]
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", repo):
        raise ValueError(f"Invalid GitHub repository: {repo}")
    release, asset, payload = None, None, None
    resolved_ref = requested
    if source["kind"] == "release":
        endpoint = "latest" if requested == "latest" else "tags/" + quote(requested, safe="")
        release = net.api(f"repos/{repo}/releases/{endpoint}")
        resolved_ref = release["tag_name"]
        matches = [a for a in release["assets"] if re.fullmatch(source["asset_pattern"], a["name"])]
        if len(matches) != 1:
            raise ValueError(f"{repo}: expected one release asset matching {source['asset_pattern']!r}; found {len(matches)}")
        asset = matches[0]
    elif source["kind"] != "git":
        raise ValueError(f"Unsupported source kind: {source['kind']}")
    commit = net.api(f"repos/{repo}/commits/{quote(resolved_ref, safe='')}")["sha"]
    tree = net.api(f"repos/{repo}/git/trees/{commit}?recursive=1")
    if tree.get("truncated"):
        raise ValueError(f"{repo}: GitHub returned a truncated file tree")
    entries = tree["tree"]
    if asset:
        digest = asset.get("digest") or ""
        if digest and not re.fullmatch(r"sha256:[0-9a-f]{64}", digest):
            raise ValueError(f"Unsupported release digest: {digest}")
        if not digest:
            print(f"::warning::{repo}/{asset['name']}: upstream publishes no SHA-256; using asset identity and local cache checksums")
        payload = net.download(asset["browser_download_url"],
                               f"release:{repo}:{asset['id']}:{asset['updated_at']}:{digest}", digest=digest)
        if asset.get("size") is not None and len(payload) != asset["size"]:
            raise ValueError(f"Release asset size mismatch: {repo}/{asset['name']}")
    record = {"id": source["id"], "repository": repo, "requested_ref": requested,
              "resolved_ref": resolved_ref, "commit": commit,
              "license_label": source["license_label"], "attribution": source["attribution"],
              "note": source.get("note", "Redistributed unchanged; no subsetting, merging or renaming."),
              "files": [], "notices": []}
    if asset:
        record["release_asset"] = {k: asset.get(k) for k in ("name", "id", "updated_at", "digest", "browser_download_url")}
    font_parents: set[PurePosixPath] = set()
    for spec in source["files"]:
        name = spec["name"]
        if safe_relative(name).name != name:
            raise ValueError(f"Font names must be plain basenames: {name}")
        item = {"name": name}
        if asset:
            data, member = archive_member(payload, name) if source.get("archive") else (payload, "")
            item.update(url=asset["browser_download_url"], archive_member=member)
        else:
            entry = pick_entry(entries, spec)
            data, url = raw_file(net, repo, commit, entry)
            item.update(url=url, path=entry["path"], git_blob=entry["sha"])
            font_parents.update(PurePosixPath(entry["path"]).parents)
        item.update(sha256=sha256(data), bytes=len(data), metadata=font_metadata(data))
        (stage / name).write_bytes(data)
        record["files"].append(item)
    # Preserve matching upstream licenses at the resolved source revision.
    # Checking the marker prevents accidentally using Plangothic's MIT code license.
    candidates = [e for e in entries if e.get("type") == "blob" and e["path"] in source.get("license_candidates", [])]
    selected: dict[str, tuple[dict, bytes, str]] = {}
    marker = source.get("license_marker", "")
    for entry in candidates:
        data, url = raw_file(net, repo, commit, entry)
        if not marker or marker.casefold() in data.decode("utf-8", errors="replace").casefold():
            selected[entry["path"]] = (entry, data, url)
    if source.get("require_license", True) and not selected:
        raise ValueError(f"No matching upstream license for {repo}@{commit}")
    for entry in entries:
        if (entry.get("type") == "blob" and
            PurePosixPath(entry["path"]).parent in font_parents and
            NOTICE_RE.match(PurePosixPath(entry["path"]).name) and
            entry.get("size", 0) <= 1024 * 1024):
            if entry["path"] not in selected:
                data, url = raw_file(net, repo, commit, entry)
                selected[entry["path"]] = (entry, data, url)
    for path, (entry, data, url) in sorted(selected.items()):
        relative = PurePosixPath("upstream-licenses") / source["id"] / safe_relative(path)
        dest = stage / relative
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(data)
        record["notices"].append({"file": str(relative), "url": url, "sha256": sha256(data)})
    # Keep any license/credits files shipped inside the release archive as well.
    if asset and source.get("archive"):
        with zipfile.ZipFile(__import__("io").BytesIO(payload)) as archive:
            for entry in archive.infolist():
                if not entry.is_dir() and NOTICE_RE.match(PurePosixPath(entry.filename).name):
                    rel = safe_relative(entry.filename)
                    if entry.file_size > 1024 * 1024:
                        raise ValueError(f"Unexpectedly large notice: {entry.filename}")
                    data = archive.read(entry)
                    relative = PurePosixPath("upstream-licenses") / source["id"] / "release-archive" / rel
                    dest = stage / relative
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    dest.write_bytes(data)
                    record["notices"].append({"file": str(relative), "url": asset["browser_download_url"],
                                               "archive_member": entry.filename, "sha256": sha256(data)})
    return record


def verify(output: Path, theme: Path, archive_path: Path | None = None) -> None:
    manifest = json.loads((output / "FONT_SOURCES.json").read_text(encoding="utf-8"))
    files = [item for source in manifest["sources"] for item in source["files"]]
    names = {item["name"] for item in files}
    required = referenced_fonts(theme)
    if names != required:
        raise ValueError(f"Theme/manifest mismatch; missing={required - names}, unused={names - required}")
    for item in files:
        data = (output / item["name"]).read_bytes()
        font_metadata(data)
        if sha256(data) != item["sha256"]:
            raise ValueError(f"Font checksum mismatch: {item['name']}")
    notices = [n for s in manifest["sources"] for n in s["notices"]]
    for item in notices:
        if sha256((output / item["file"]).read_bytes()) != item["sha256"]:
            raise ValueError(f"Notice checksum mismatch: {item['file']}")
    if archive_path:
        with zipfile.ZipFile(archive_path) as archive:
            prefix = output.as_posix().strip("/") + "/"
            contents = {name.removeprefix("./"): name for name in archive.namelist()}
            for relative in [i["name"] for i in files] + [i["file"] for i in notices] + ["FONT_SOURCES.json", "FONT_NOTICES.md", "SHA256SUMS"]:
                name = prefix + relative
                if name not in contents or archive.read(contents[name]) != (output / relative).read_bytes():
                    raise ValueError(f"Missing or altered release member: {name}")
    print(f"Verified {len(files)} fonts and {len(notices)} upstream notice files")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=Path(".github/sync/fonts.json"))
    parser.add_argument("--output", type=Path, default=Path("themes/fonts"))
    parser.add_argument("--theme", type=Path, default=Path("themes/lib/nekocat/generalstyle.lua"))
    parser.add_argument("--cache", type=Path, default=Path("downloads/fonts"))
    parser.add_argument("--versions-file", type=Path, default=Path(".github/sync/sha/versions.json"))
    parser.add_argument("--result", type=Path)
    parser.add_argument("--verify-only", action="store_true")
    parser.add_argument("--verify-zip", type=Path)
    args = parser.parse_args()
    if args.verify_only or args.verify_zip:
        verify(args.output, args.theme, args.verify_zip)
        return
    config = json.loads(args.config.read_text(encoding="utf-8"))
    if config.get("schema_version") != 1:
        raise ValueError("Unsupported fonts.json schema")
    names = [f["name"] for source in config["sources"] for f in source["files"]]
    if len(names) != len(set(names)) or set(names) != referenced_fonts(args.theme):
        raise ValueError("fonts.json must contain exactly the theme font_list, without duplicate filenames")
    ids = [s["id"] for s in config["sources"]]
    if len(ids) != len(set(ids)) or any(not re.fullmatch(r"[a-z0-9-]+", v) for v in ids):
        raise ValueError("Invalid or duplicate source IDs")
    net = Network(args.cache)
    with tempfile.TemporaryDirectory(prefix="rime-fonts-") as temp:
        stage = Path(temp)
        stage.chmod(0o755)
        records = []
        for source in config["sources"]:
            print(f"::group::Fonts: {source['id']}", flush=True)
            records.append(build_source(net, source, stage))
            print("::endgroup::", flush=True)
        bundle = {"schema_version": 1, "sources": records}
        write_json(stage / "FONT_SOURCES.json", bundle)
        notices = ["# Font sources and upstream notices", "",
                   "Fonts are redistributed unchanged. Source revisions and upstream notices are listed below.",
                   "Third-party fonts retain their upstream licenses.", ""]
        checksums = []
        for source in records:
            notices.extend([f"## {source['id']}", "", f"Attribution: {source['attribution']}", "",
                            f"Source: https://github.com/{source['repository']}/tree/{source['commit']}", "",
                            f"License information: {source['license_label']}", "", source["note"], ""])
            for item in source["files"]:
                checksums.append(f"{item['sha256']}  {item['name']}")
                notices.extend([f"- `{item['name']}`: {item['url']}"])
                for field, values in item["metadata"].items():
                    if field in ("copyright", "license", "license_url", "designer"):
                        for value in values:
                            notices.append(f"  - Embedded {field}: {value.replace(chr(10), ' ')}")
            notices.extend(["", "Preserved upstream notices:"])
            notices.extend(f"- [{n['file']}]({n['file']})" for n in source["notices"])
            notices.append("")
        (stage / "FONT_NOTICES.md").write_text("\n".join(notices) + "\n", encoding="utf-8")
        (stage / "SHA256SUMS").write_text("\n".join(sorted(checksums)) + "\n", encoding="utf-8")
        verify(stage, args.theme)
        args.output.mkdir(parents=True, exist_ok=True)
        # Replace generated font assets while preserving other files.
        for old in args.output.rglob("*"):
            if old.is_file() and old.suffix.lower() in FONT_SUFFIXES:
                old.unlink()
        if (args.output / "upstream-licenses").exists():
            shutil.rmtree(args.output / "upstream-licenses")
        shutil.copytree(stage, args.output, dirs_exist_ok=True)
    versions = json.loads(args.versions_file.read_text()) if args.versions_file.exists() else {}
    version = "sha256:" + sha256(json.dumps(bundle, sort_keys=True, ensure_ascii=False).encode())
    changed = versions.get("theme-fonts") != version
    versions["theme-fonts"] = version
    write_json(args.versions_file, versions)
    if args.result:
        write_json(args.result, {"changed": changed, "font_count": len(names), "version": version})
    net.prune()
    print(f"Font bundle ready: count={len(names)}, changed={str(changed).lower()}")


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        print(f"::error::Font synchronization failed: {exc}", file=sys.stderr)
        sys.exit(1)
