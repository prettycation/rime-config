"""Offline tests. All font bytes are synthetic test fixtures, not shipped fonts."""
from __future__ import annotations

import contextlib
import copy
import io
import json
import os
from pathlib import Path
import struct
import sys
import tempfile
import unittest
from unittest.mock import patch
import zipfile

import sync_fonts as sf

CONFIG_PATH = Path(__file__).resolve().parents[1] / "sync" / "fonts.json"


def sample_font(label: str = "Synthetic test font") -> bytes:
    text = label.encode("utf-16-be")
    name = struct.pack(">HHH", 0, 1, 18) + struct.pack(">HHHHHH", 3, 1, 0x409, 0, len(text), 0) + text
    tables = [(b"head", b"\0" * 54), (b"maxp", b"\0" * 32),
              (b"cmap", b"\0" * 4), (b"name", name)]
    result = bytearray(struct.pack(">4sHHHH", b"\0\1\0\0", len(tables), 0, 0, 0))
    offset = 12 + len(tables) * 16
    for tag, data in tables:
        result.extend(struct.pack(">4sIII", tag, 0, offset, len(data)))
        offset += len(data)
    for _, data in tables:
        result.extend(data)
    return bytes(result)


def make_archive(members: dict[str, bytes]) -> bytes:
    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, "w") as archive:
        for name, data in members.items():
            archive.writestr(name, data)
    return buffer.getvalue()


class BasicTests(unittest.TestCase):
    def test_font_metadata(self):
        self.assertEqual(sf.font_metadata(sample_font())["copyright"], ["Synthetic test font"])

    def test_reject_html_and_lfs_pointer(self):
        for data in (b"<html>404 Not Found</html>", b"version https://git-lfs.github.com/spec/v1\n"):
            with self.assertRaises(ValueError):
                sf.font_metadata(data)

    def test_reject_truncated_font(self):
        with self.assertRaises(ValueError):
            sf.font_metadata(sample_font()[:-4])

    def test_duplicate_tree_names_require_explicit_path(self):
        entries = [{"type": "blob", "path": p} for p in ("a/A.ttf", "b/A.ttf")]
        with self.assertRaises(ValueError):
            sf.pick_entry(entries, {"name": "A.ttf"})
        self.assertEqual(sf.pick_entry(entries, {"name": "A.ttf", "path": "b/A.ttf"})["path"], "b/A.ttf")

    def test_archive_extracts_exact_basename(self):
        data = sample_font()
        archive = make_archive({"package/fonts/A.otf": data, "package/unused.otf": b"not-used"})
        self.assertEqual(sf.archive_member(archive, "A.otf"), (data, "package/fonts/A.otf"))

    def test_archive_duplicate_and_traversal_fail(self):
        with self.assertRaises(ValueError):
            sf.archive_member(make_archive({"a/A.otf": b"a", "b/A.otf": b"b"}), "A.otf")
        with self.assertRaises(ValueError):
            sf.archive_member(make_archive({"../A.otf": b"a"}), "A.otf")

    def test_theme_ignores_commented_font(self):
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "theme.lua"
            path.write_text('fonts = { font_list = { "A.ttf", -- "Old.ttf"\n "B.otf" }}')
            self.assertEqual(sf.referenced_fonts(path), {"A.ttf", "B.otf"})

    def test_cached_download_recovers_from_corruption(self):
        with tempfile.TemporaryDirectory() as temp:
            net = sf.Network(Path(temp))
            data = b"original bytes"
            with patch.object(net, "request", return_value=data) as download:
                self.assertEqual(net.download("https://example.test/f", "id", digest=sf.sha256(data)), data)
                self.assertEqual(download.call_count, 1)
                net.download("https://example.test/f", "id", digest=sf.sha256(data))
                self.assertEqual(download.call_count, 1)
                next(Path(temp).glob("*.bin")).write_bytes(b"corrupted")
                net.download("https://example.test/f", "id", digest=sf.sha256(data))
                self.assertEqual(download.call_count, 2)

    def test_wrong_upstream_checksum_fails(self):
        with tempfile.TemporaryDirectory() as temp:
            net = sf.Network(Path(temp))
            with patch.object(net, "request", return_value=b"wrong"):
                with self.assertRaises(ValueError):
                    net.download("https://example.test/f", "id", digest="0" * 64)

    def test_git_lfs_download_and_verification(self):
        with tempfile.TemporaryDirectory() as temp:
            font = sample_font()
            pointer = ("version https://git-lfs.github.com/spec/v1\noid sha256:" + sf.sha256(font) + "\nsize " + str(len(font)) + "\n").encode()
            entry = {"path": "fonts/A.ttf", "sha": sf.git_sha(pointer)}
            net = sf.Network(Path(temp))
            with patch.object(net, "request", side_effect=[pointer, font]):
                result, url = sf.raw_file(net, "example/repo", "a" * 40, entry)
            self.assertEqual(result, font)
            self.assertIn("media.githubusercontent.com", url)


class IntegrationTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.previous = Path.cwd()
        os.chdir(self.temp.name)
        self.config = json.loads(CONFIG_PATH.read_text())
        Path(".github/sync").mkdir(parents=True)
        sf.write_json(Path(".github/sync/fonts.json"), self.config)
        self.theme = Path("themes/lib/nekocat/generalstyle.lua")
        self.theme.parent.mkdir(parents=True)
        names = [f['name'] for source in self.config['sources'] for f in source['files']]
        self.theme.write_text('fonts = {font_list = {' + ','.join(json.dumps(n) for n in names) + '}}')
        sf.write_json(Path(".github/sync/sha/versions.json"), {"existing-input-scheme": "unchanged"})
        self.responses = {}
        self.urls = []
        self.commit = "a" * 40
        for number, source in enumerate(self.config["sources"]):
            repo = source["repository"]
            tree = []
            def blob(path, data):
                tree.append({"path": path, "type": "blob", "size": len(data), "sha": sf.git_sha(data)})
                self.responses[f"https://raw.githubusercontent.com/{repo}/{self.commit}/{path}"] = data
            license_path = source["license_candidates"][0]
            blob(license_path, (source["license_marker"] + "\nSynthetic test notice\n").encode())
            ref = source["ref"]
            if source["kind"] == "git":
                for spec in source["files"]:
                    path = spec.get("path", "app/assets/fonts/" + spec["name"])
                    blob(path, sample_font(spec["name"]))
                    # A separate adjacent notice must also survive packaging.
                    if source["id"] == "carlsonfont":
                        blob(str(Path(path).parent / "NOTICE.txt"), b"Synthetic adjacent notice")
            else:
                ref = "v-test"
                if source["archive"]:
                    asset_name = "Plangothic-OTF.zip"
                    payload = make_archive({**{"bundle/" + f["name"]: sample_font(f["name"]) for f in source["files"]},
                                            "bundle/NOTICE.txt": b"Synthetic archive notice"})
                else:
                    asset_name = source["files"][0]["name"]
                    payload = sample_font(asset_name)
                url = f"https://github.com/{repo}/releases/download/{ref}/{asset_name}"
                self.responses[url] = payload
                asset = {"name": asset_name, "id": number + 1, "size": len(payload),
                         "updated_at": "2026-01-01T00:00:00Z", "digest": "sha256:" + sf.sha256(payload),
                         "browser_download_url": url}
                self.responses[f"https://api.github.com/repos/{repo}/releases/latest"] = json.dumps({"tag_name": ref, "assets": [asset]}).encode()
            self.responses[f"https://api.github.com/repos/{repo}/commits/{ref}"] = json.dumps({"sha": self.commit}).encode()
            self.responses[f"https://api.github.com/repos/{repo}/git/trees/{self.commit}?recursive=1"] = json.dumps({"tree": tree, "truncated": False}).encode()
        def fake_request(_net, url, *, api=False):
            self.urls.append(url)
            if url not in self.responses:
                raise AssertionError(f"Unmocked network access: {url}")
            return self.responses[url]
        self.mock = patch.object(sf.Network, "request", fake_request)
        self.mock.start()

    def tearDown(self):
        self.mock.stop()
        os.chdir(self.previous)
        self.temp.cleanup()

    def run_main(self, *extra):
        with patch.object(sys, "argv", ["sync_fonts.py", "--result", "result.json", *extra]), contextlib.redirect_stdout(io.StringIO()):
            sf.main()

    def test_full_six_font_build_cache_and_versions(self):
        self.run_main()
        result = json.loads(Path("result.json").read_text())
        self.assertTrue(result["changed"])
        self.assertEqual(result["font_count"], 6)
        versions = json.loads(Path(".github/sync/sha/versions.json").read_text())
        self.assertEqual(versions["existing-input-scheme"], "unchanged")
        download_count = len([u for u in self.urls if not u.startswith("https://api.")])
        self.run_main()
        self.assertFalse(json.loads(Path("result.json").read_text())["changed"])
        self.assertEqual(len([u for u in self.urls if not u.startswith("https://api.")]), download_count)
        self.assertTrue(Path("themes/fonts/upstream-licenses/carlsonfont/app/assets/fonts/NOTICE.txt").exists())
        self.assertTrue(Path("themes/fonts/upstream-licenses/plangothic/release-archive/bundle/NOTICE.txt").exists())
        self.assertEqual(len(list(Path("themes/fonts").glob("*.ttf"))) + len(list(Path("themes/fonts").glob("*.otf"))), 6)

    def test_zip_contains_fonts_and_notices_and_detects_missing_font(self):
        self.run_main()
        with zipfile.ZipFile("ok.zip", "w") as archive:
            for path in Path("themes/fonts").rglob("*"):
                if path.is_file():
                    archive.write(path, "./" + path.as_posix())
        with contextlib.redirect_stdout(io.StringIO()):
            sf.verify(Path("themes/fonts"), self.theme, Path("ok.zip"))
        with zipfile.ZipFile("missing.zip", "w") as archive:
            for path in Path("themes/fonts").rglob("*"):
                if path.is_file() and path.name != "CarlsonFont.ttf":
                    archive.write(path, path.as_posix())
        with self.assertRaises(ValueError):
            sf.verify(Path("themes/fonts"), self.theme, Path("missing.zip"))

    def test_unknown_font_requires_manifest_update(self):
        self.theme.write_text('font_list = {"Unknown.ttf"}')
        with self.assertRaises(ValueError):
            self.run_main()
        self.assertFalse(self.urls)

    def test_upstream_download_failure_does_not_write_versions(self):
        url = next(u for u in self.responses if u.endswith("CarlsonFont.ttf"))
        del self.responses[url]
        with self.assertRaises(AssertionError):
            self.run_main()
        versions = json.loads(Path(".github/sync/sha/versions.json").read_text())
        self.assertEqual(versions, {"existing-input-scheme": "unchanged"})
        self.assertFalse(Path("themes/fonts").exists())

    def test_mismatched_license_fails(self):
        source = self.config["sources"][0]
        source["license_marker"] = "A license which is not present"
        sf.write_json(Path(".github/sync/fonts.json"), self.config)
        with self.assertRaises(ValueError):
            self.run_main()
        self.assertFalse(Path("themes/fonts").exists())

    def test_truncated_github_tree_fails(self):
        url = next(u for u in self.responses if "/git/trees/" in u)
        data = json.loads(self.responses[url])
        data["truncated"] = True
        self.responses[url] = json.dumps(data).encode()
        with self.assertRaises(ValueError):
            self.run_main()

    def test_preserves_user_font_directory_readme(self):
        path = Path("themes/fonts/README.md")
        path.parent.mkdir(parents=True)
        path.write_text("User-authored documentation")
        Path("themes/fonts/unused-old.ttf").write_bytes(b"old bytes")
        self.run_main()
        self.assertEqual(path.read_text(), "User-authored documentation")
        self.assertFalse(Path("themes/fonts/unused-old.ttf").exists())

    def test_tampered_font_and_notice_detected(self):
        self.run_main()
        font = Path("themes/fonts/CarlsonFont.ttf")
        original = font.read_bytes()
        font.write_bytes(b"bad bytes")
        with self.assertRaises(ValueError):
            sf.verify(Path("themes/fonts"), self.theme)
        font.write_bytes(original)
        notice = next(Path("themes/fonts/upstream-licenses/carlsonfont").glob("LICENSE*"))
        notice.write_bytes(b"tampered")
        with self.assertRaises(ValueError):
            sf.verify(Path("themes/fonts"), self.theme)


if __name__ == "__main__":
    unittest.main()
