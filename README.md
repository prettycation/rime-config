# 灵韵输入法配置

面向 [灵韵输入法（LyraIME）](https://github.com/Carlson24/LyraIME) 的个人 Rime 配置，包含 **万象 Pro 小鹤双拼、鸢鸣万象李氏三拼、共享词库与语言模型，以及 NekoCatppuccin 主题**。

[下载 Nightly](https://github.com/prettycation/rime-config/releases/tag/nightly) · [查看自动更新](https://github.com/prettycation/rime-config/actions/workflows/sync-assets-to-webdav.yml) · [万象官方文档](https://amzxyz.github.io/rime-wanxiang/)

> **主题来源**：本仓库主题修改自 [Carlson24/rime-config](https://github.com/Carlson24/rime-config) 的 NekoCatppuccin，原作者 Carlson24（鹤衔春雪），在其基础上调整布局、样式与资源配置。

本仓库按个人习惯维护，首次使用或更新前，请备份现有配置、用户词典与自定义短语。

## 内容概览

| 部分        | 内容                                                               |
| ----------- | ------------------------------------------------------------------ |
| `wanxiang/` | 万象 Pro ：小鹤双拼、小鹤提权与飞键；另启用万象英文方案            |
| `yoemin/`   | 鸢鸣万象                                                           |
| `shared/`   | 扩展词典入口、Pro 词库、尖音词库、额外词库、万象语言模型与共享配置 |
| `themes/`   | NekoCatppuccin / NekoCatppuccinPad 主题、Lua 模块、字体及背景资源  |
| `.github/`  | 上游资源更新、WebDAV 同步与 Nightly 发布工作流                     |

本仓库万象 Pro 采用小鹤双拼，构建时主要词库取自 [yuanz-12/momo](https://github.com/yuanz-12/momo) 的**魔改墨奇码**，不能直接按原版墨奇码理解全部拆分。

## 下载与使用

### 1. 下载组装包，而不是源码 ZIP

推荐从 [Nightly Release](https://github.com/prettycation/rime-config/releases/tag/nightly) 下载：

| 文件                                                                                                                           | 用途                          |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------- |
| [LyraIME-nightly.zip](https://github.com/prettycation/rime-config/releases/download/nightly/LyraIME-nightly.zip)               | Actions 组装的配置与资源包    |
| [LyraIME-nightly.zip.sha256](https://github.com/prettycation/rime-config/releases/download/nightly/LyraIME-nightly.zip.sha256) | 对应压缩包的 SHA-256 校验文件 |

将两个文件放在同一目录，可在支持 `sha256sum` 的环境中校验：

```sh
sha256sum -c LyraIME-nightly.zip.sha256
```

仓库主要保存个人定制文件，方案本体、Lua 脚本、词库和模型由 Actions 补齐。GitHub 的 **Code → Download ZIP** 和 Release 中自动生成的 **Source code** 都不等同于 `LyraIME-nightly.zip`，不能据此认为运行资源已经完整。

Nightly 是滚动更新的预发布版本：同一个 `nightly` 标签会被重建，不是历史版本存档。建议保留最近一次正常使用的压缩包，方便回退。

### 2. 放入灵韵用户数据目录

先安装支持本仓库 Lua 主题与方案包结构的 [LyraIME](https://github.com/Carlson24/LyraIME)，并完成数据备份。

将组装包中的内容解压到**灵韵设置中指定的用户数据目录**。当前灵韵源码的默认目录为共享存储下的 `Documents/LyraIME/`；自定义目录或调试版可能不同，以应用设置为准。

解压后应保持以下同级关系，不要额外套一层 `rime-config-main/` 或 `LyraIME-nightly/`：

```text
<灵韵用户数据目录>/
├── shared/
├── wanxiang/
├── yoemin/
└── themes/
```

灵韵将 `wanxiang/`、`yoemin/` 分别作为方案包目录，`shared/` 作为共享数据目录，`themes/` 作为用户主题目录。**不要把两个方案包的文件直接混合到同一个目录**，否则同名配置与脚本可能相互覆盖。

### 3. 选择方案并重新部署

在灵韵的方案管理中确认方案包已被识别，选择需要的方案并执行重新部署：

| 方案包     | 本仓库默认启用的方案 ID            |
| ---------- | ---------------------------------- |
| `wanxiang` | `wanxiang_pro`、`wanxiang_english` |
| `yoemin`   | `wanxiang_yoemin`                  |

正常组装的方案包中应包含 `default.yaml` 和对应的 `*.schema.yaml`。若应用无法识别方案包，先检查是否误用了源码 ZIP、漏解压资源，或目录多嵌套了一层。

主题需选择 `NekoCatppuccin` 或 `NekoCatppuccinPad`。`themes/fonts/` 与 `themes/backgrounds/` 依赖的字体与背景资源需要单独下载。

> 本仓库主要面向灵韵。其他 Rime 前端可参考方案配置，但需要自行适配目录、引擎与 Lua 依赖；这里的 Lua 主题不能直接当作小狼毫、鼠须管或普通 Trime YAML 主题使用。

## 目录与配置入口

下列为关键文件示意；标注「构建补齐」的资源由工作流下载，源码目录与 Nightly 解压目录不完全相同。

```text
.
├── .github/
│   ├── workflows/sync-assets-to-webdav.yml
│   └── sync/sha/versions.json
├── shared/
│   ├── shared_config.yaml              # 可复用配置片段
│   ├── wan.extended.dict.yaml          # 共享扩展词典入口
│   ├── dicts/                          # Pro 词库；构建时补齐
│   ├── dicts_zian/                     # 尖音系列词库；构建时补齐
│   ├── dicts_extra/                    # 额外词库
│   └── wanxiang-lts-zh-hans.gram        # 语言模型；构建补齐
├── wanxiang/
│   ├── default.custom.yaml             # 启用方案、候选数量等
│   ├── wanxiang_pro.custom.yaml        # 万象 Pro 个人定制
│   ├── wanxiang_english.custom.yaml    # 万象英文定制
│   └── …                              # 上游方案与配套资源；构建补齐
├── yoemin/
│   ├── default.custom.yaml
│   ├── wanxiang_yoemin.custom.yaml
│   ├── custom_phrase.txt
│   └── …                              # 鸢鸣万象上游资源；构建补齐
└── themes/
    ├── NekoCatppuccin.lua
    ├── NekoCatppuccinPad.lua
    ├── lib/nekocat/
    ├── fonts/
    ├── backgrounds/
    └── doc/theme-dsl.lua
```

`.github/` 用于仓库维护，不包含在 Nightly 运行资源包中。

## 输入方案说明

### 万象 Pro：小鹤双拼 + 魔改墨奇辅码

主要配置见 [`wanxiang/wanxiang_pro.custom.yaml`](wanxiang/wanxiang_pro.custom.yaml)。

当前拼写规则依次组合小鹤双拼、个人提权规则、直接辅助与飞键规则：

```yaml
patch:
  speller/algebra:
    __patch:
      - wanxiang_algebra:/pro/小鹤双拼
      - 小鹤双拼提权
      - wanxiang_algebra:/pro/直接辅助
      - 小鹤双拼飞键
```

“直接辅助”允许在拼音编码后直接追加辅助码；它与需要 `/` 引导的“间接辅助”不同。具体拆分以所用词库和 [momo 的改码说明](https://github.com/yuanz-12/momo) 为准，规则原理参考[万象辅助码文档](https://amzxyz.github.io/rime-wanxiang/doc/aux_code/)。

“小鹤双拼提权”和“小鹤双拼飞键”定义在同一配置文件末尾。飞键使用派生规则增加替代编码，例如 `cv → ck`、`jp → jf`。文件中还保留了自然码提权规则块，但当前拼写链没有引用它。

主要定制如下：

| 项目         | 当前设置                                               |
| ------------ | ------------------------------------------------------ |
| 输出偏好     | 简体、中文标点、半角字符                               |
| 候选呈现     | 每页 6 项，使用苏州码子候选标签                        |
| 辅助提示     | 开启辅助码拆分与注释、超级提示                         |
| 候选过滤     | 默认小字集，使用 `aj` 基础集合并补充个人白名单、黑名单 |
| 默认关闭     | 表情候选、翻译候选、上下文调频开关                     |
| 预编辑显示   | 原编码                                                 |
| 英文自动空格 | 关闭                                                   |
| 提示类型     | 不加载化学式与车牌类提示规则                           |

主翻译器与两处造词翻译器统一指向 `wan.extended`：修改词典入口时，需要一起检查 `translator/dictionary`、`user_dict_set/dictionary` 与 `add_user_dict/dictionary`，避免查询和造词使用不同词典。

这些设置以本仓库补丁及其匹配的上游方案为准；`switches/@数字` 依赖上游列表顺序，更新后应核对实际开关，不能只看旧注释。

### 万象英文

[`wanxiang/wanxiang_english.custom.yaml`](wanxiang/wanxiang_english.custom.yaml) 引用万象英文通用规则与小鹤双拼规则，并调整分词符、翻页和次选／三选按键。

它是 `wanxiang` 方案包中单独启用的 `wanxiang_english` 方案，不应与中文方案中的英文候选开关或英文自动空格设置混为一谈。

### 鸢鸣万象：李氏三拼

[`yoemin/`](yoemin/) 对接 [yuanz-12/wanxiang_yoemin](https://github.com/yuanz-12/wanxiang_yoemin)，使用带声调的**李氏三拼**音码，并保留上游方案自身的拼写与功能结构。

本仓库主要为它统一语言模型、自定义短语、候选注释、字符过滤和部分按键设置。构建时不采用上游同名的 `wan.extended.dict.yaml`，而是使用本仓库的共享词典入口。

两套方案各自保留配套脚本。日期、计算器、反查等扩展功能的触发方式应分别参考对应上游，万象 Pro 只有部分快捷命令可以直接套用到鸢鸣万象。

### 本仓库明确设置的按键

下表只列本仓库直接配置的部分，不是完整快捷键表：

| 按键／设置                | 作用与范围                                                             |
| ------------------------- | ---------------------------------------------------------------------- |
| `;`                       | 有候选菜单时选择第 2 项；Pro、英文、鸢鸣均有配置                       |
| `'`                       | 有候选菜单时选择第 3 项；Pro、英文、鸢鸣均有配置                       |
| `-` / `=`                 | Pro、英文中映射为向前／向后翻页，分别受 `paging` / `has_menu` 条件限制 |
| `Shift_L` / `Shift_R`     | 两个方案包的默认配置设为 `commit_code`                                 |
| `speller/delimiter: "':"` | 调整分词符配置；不要把单引号三选与手动分词操作混淆                     |
| `,`                       | Pro 的 `super_tips/tips_key` 设为逗号                                  |

软键盘是否提供对应按键或手势，还取决于当前主题布局。

## 共享词库与配置

### 扩展词典

[`shared/wan.extended.dict.yaml`](shared/wan.extended.dict.yaml) 是词典总入口，通过 `import_tables` 组织三组内容：

| 目录           | 用途                                                           |
| -------------- | -------------------------------------------------------------- |
| `dicts/`       | 基础、联想、错音、多音、诗词、地名、专业领域、人物、萌娘等词表 |
| `dicts_zian/`  | 对应的尖音扩展词表                                             |
| `dicts_extra/` | 额外词表，当前入口包含 `zhuanwen.pro`                          |

常规 Pro 词表与尖音词表由工作流从 momo 获取，并在组装时分目录存放。仓库中已被 Git 跟踪的同名文件会在下载后恢复，因此最终内容以构建结果为准。

增删词库时，请同步维护 `import_tables` 与实际文件。辅助码、带调编码和方案拼写规则必须匹配，不要直接换成编码格式不同的基础版词库。

### 语言模型与共享片段

[`shared/shared_config.yaml`](shared/shared_config.yaml) 当前供两套中文方案显式引用的部分是：

| 片段            | 用途                                                 |
| --------------- | ---------------------------------------------------- |
| `grammar`       | 使用 `wanxiang-lts-zh-hans` 模型，并设置组句搭配参数 |
| `custom_phrase` | 使用 `stabledb` 的自定义编码短语，关闭补全和造句     |
| `super_comment` | 设置候选注释、拆分信息与候选来源标记                 |

模型文件由 [RIME-LMDG](https://github.com/amzxyz/RIME-LMDG) 的 `LTS` Release 获取，名称为 `wanxiang-lts-zh-hans.gram`。语言模型的组句能力与额外的上下文调频、预测开关是不同层面的功能，不应将关闭某个开关理解为完全不使用模型。

**`shared_config.yaml` 不是自动全局覆盖文件。** 文件中还定义了其他配置节点，但只有被方案引用或导入的内容才会参与最终配置。例如：

```yaml
patch:
  grammar:
    __include: shared_config.yaml:/grammar
```

仅在共享文件中修改一组快捷键，不代表所有方案都会采用它。具体合并机制见[万象 Patch 方法论](https://amzxyz.github.io/rime-wanxiang/doc/patch方法论/)。

### 自定义短语

短语文件名应与最终的 `custom_phrase/user_dict` 一致，不含 `.txt` 后缀。

当前共享片段使用 `user_phrase`，Pro 补丁中还存在指向 `custom_phrase01` 的单独设置。维护时应统一这两处定义，并在部署后的 `build/*.schema.yaml` 中核对最终值；不能仅凭目录里存在 `custom_phrase.txt` 就认定该文件正在生效。

确定最终值后，在当前方案的用户目录中创建对应的 UTF-8 文本文件。示例内容如下，列之间使用实际的 Tab：

```text
我的常用短语 myphrase 100
另一条短语 myphrase 90
```

词条、自定义编码和权重分别占一列。修改后重新部署；个人短语与用户词典应另行备份，避免更新时被同名文件覆盖。

## NekoCatppuccin 主题

主题基于 [Carlson24/rime-config](https://github.com/Carlson24/rime-config) 修改，使用灵韵的 Lua 主题 DSL。共享实现位于 [`themes/lib/nekocat/`](themes/lib/nekocat/)。

| 入口                                                    | 配置差异                                       |
| ------------------------------------------------------- | ---------------------------------------------- |
| [`NekoCatppuccin.lua`](themes/NekoCatppuccin.lua)       | 常规布局尺寸，竖屏键盘高度配置为 270           |
| [`NekoCatppuccinPad.lua`](themes/NekoCatppuccinPad.lua) | 较高的竖屏键盘与候选区，竖屏键盘高度配置为 295 |

主题包含候选区、工具栏、预设按键、文字键盘与符号面板。工具栏提供语音、剪贴板、编辑、撤销／重做、悬浮与单手模式等入口；实际能力由灵韵应用提供。

文字键盘模块包括小鹤／自然码提示布局、部分多键位布局，以及鸢鸣万象和李氏三拼动态键盘。**主题中存在某种布局，不代表当前方案已经启用相应拼写规则；更换键盘外观不会自动把小鹤双拼变成李氏三拼。**

当前配色模块默认选择“灰白／灰黑”，并包含“彩虹”等思无邪系列移植配色。主题名称沿用 NekoCatppuccin，但配色与背景不只包含原始 Catppuccin 风格；相关来源也保留在配色文件注释中。

定制入口：

| 文件／目录                               | 适合修改的内容             |
| ---------------------------------------- | -------------------------- |
| `themes/lib/nekocat/generalstyle.lua`    | 通用样式、字号、字体组合等 |
| `themes/lib/nekocat/color_schemes.lua`   | 默认配色与配色注册         |
| `themes/lib/nekocat/textkeyboard.lua`    | 文字键盘布局               |
| `themes/lib/nekocat/preset_keys.lua`     | 预设按键行为               |
| `themes/lib/nekocat/toolbar.lua`         | 工具栏入口                 |
| `themes/lib/nekocat/liquid_keyboard.lua` | 符号与扩展面板             |
| `themes/fonts/`、`themes/backgrounds/`   | 字体、图标字形与背景资源   |

主题 DSL 可参考仓库中的 [`themes/doc/theme-dsl.lua`](themes/doc/theme-dsl.lua)。出现按键图标方框、字体缺失或背景异常时，先检查资源是否完整及路径是否保持一致。

## 自动更新与发布

工作流：[`Sync Assets to WebDAV`](.github/workflows/sync-assets-to-webdav.yml)。

### Actions 实际引用的上游项目

| 上游项目                                                                | 获取来源                                       | 在本仓库中的用途                                                              |
| ----------------------------------------------------------------------- | ---------------------------------------------- | ----------------------------------------------------------------------------- |
| [yuanz-12/momo](https://github.com/yuanz-12/momo)                       | `main` 分支的 `dicts-pro/`                     | 补齐 `shared/dicts/`，并将 `*.zian.pro.dict.yaml` 分离到 `shared/dicts_zian/` |
| [amzxyz/RIME-LMDG](https://github.com/amzxyz/RIME-LMDG)                 | `LTS` Release                                  | 下载 `wanxiang-lts-zh-hans.gram` 到 `shared/`                                 |
| [amzxyz/rime-wanxiang](https://github.com/amzxyz/rime-wanxiang)         | 最新 Release 的 `rime-wanxiang-moqi-fuzhu.zip` | 补齐 `wanxiang/`；排除上游 `dicts/` 与 `custom/`                              |
| [yuanz-12/wanxiang_yoemin](https://github.com/yuanz-12/wanxiang_yoemin) | `main` 分支                                    | 补齐 `yoemin/`；排除上游 `wan.extended.dict.yaml`                             |

下载完成后，工作流恢复本仓库已被 Git 跟踪的文件，再进行同步和打包：**上游补齐资源，本仓库保留个人定制**。

资源版本记录保存在 [`.github/sync/sha/versions.json`](.github/sync/sha/versions.json)。它可能保留历史键名；当前实际下载来源应以上表及工作流中的有效任务为准，而不是仅看版本记录或旧版 Release Notes。

### 触发与产物

定时任务计划在每天 **02:00 UTC（北京时间 10:00）** 运行；也支持手动运行，以及向 `main`、`CI/**`、`develop/**`、`fix/**` 分支推送时运行。

工作流使用版本记录与下载缓存检查上游变化，按条件同步到 WebDAV 的 `LyraIME/`。版本变化时提交版本记录，下载的整套资源不因此全部提交回 Git。

Nightly 仅在 `main` 分支发布：定时运行、推送到 `main`，或手动勾选 `force_nightly` 时触发发布逻辑。产物为配置 ZIP 和 SHA-256 校验文件，旧的 `nightly` Release 与标签会被替换。

### Fork 后配置

在自己仓库的 Actions Secrets 中设置：

| Secret            | 内容            |
| ----------------- | --------------- |
| `WEBDAV_URL`      | WebDAV 服务地址 |
| `WEBDAV_USERNAME` | WebDAV 用户名   |
| `WEBDAV_PASSWORD` | WebDAV 密码     |

同时启用 Actions，并确认仓库策略允许工作流所需的 `contents: write` 权限。GitHub 访问使用工作流的 `GITHUB_TOKEN`，不要将 WebDAV 密码写入配置文件或提交到仓库。

**同步安全提示：**

- 工作流使用 `rclone sync`，目标为 `webdav:LyraIME`。它会镜像构建目录，可能删除远端目标中不在源目录、且未被排除的文件。该目录应专用于配置分发，不要与手机备份、个人用户词典或其他资料混用。
- 当前匹配的不同分支共用同一 WebDAV 目标，并没有独立测试目录。测试分支也可能覆盖远端配置；需要隔离时，应先修改工作流。
- 当前流程没有“缺少 WebDAV 凭据就自动跳过”的独立保护，WebDAV 步骤失败可能阻止后续发布。只需要 GitHub Release 时，请先调整同步逻辑，不要直接照搬工作流运行。

## 定制与排错

推荐修改对应的 `*.custom.yaml`，尽量不直接修改工作流下载的方案本体。参考[万象自定义配置文档](https://amzxyz.github.io/rime-wanxiang/doc/schema_custom/)与 [Patch 方法论](https://amzxyz.github.io/rime-wanxiang/doc/patch方法论/)。

一个文件保留一个顶层 `patch:`；新增内容合并到已有节点下。像“小鹤双拼提权”这样的可复用规则块可以位于 `patch:` 之外，再通过 `__patch` 引用。`default.custom.yaml` 与方案的 `.custom.yaml` 各自补丁到对应原文件，并不是一条简单的“全局优先级链”。

| 现象                       | 优先检查                                                                         |
| -------------------------- | -------------------------------------------------------------------------------- |
| 找不到方案包               | 是否使用组装包；包内是否有 `default.yaml` 与 `*.schema.yaml`；是否多套了一层目录 |
| 部署提示缺少词典或模型     | `shared/` 是否完整；`import_tables` 是否与文件对应；模型文件名是否匹配           |
| 辅助码与预期不一致         | 当前词库是魔改墨奇，不是原版墨奇；检查词库与拼写规则是否匹配                     |
| 共享配置修改后无变化       | 方案是否实际 `__include` 了该节点；是否修改了当前启用的方案包                    |
| 自定义短语无候选           | 最终 `custom_phrase/user_dict`、文件名、Tab 分隔与文件编码是否一致               |
| 更新后开关状态不对         | 对照上游 `switches` 顺序核对 `@数字`，并查看部署后的最终配置                     |
| 主题空白、缺图或图标变方框 | Lua 模块、字体、背景是否一起保留；当前灵韵版本是否支持主题 DSL                   |

部署后的最终配置通常位于当前方案包的 `build/` 中。排查时结合日志检查 `build/*.schema.yaml`，不要只依据源码中的某一行或注释判断配置已经生效。

## 致谢与资源归属

感谢所有上游项目与贡献者：

| 项目                                                                                    | 致谢内容                              |
| --------------------------------------------------------------------------------------- | ------------------------------------- |
| [Rime](https://github.com/rime)                                                         | 输入法引擎与配置生态                  |
| [Carlson24/LyraIME](https://github.com/Carlson24/LyraIME)                               | 灵韵 Android 输入法与 Lua 主题系统    |
| [Carlson24/rime-config](https://github.com/Carlson24/rime-config)                       | 本仓库 NekoCatppuccin 主题的修改来源  |
| [amzxyz/rime-wanxiang](https://github.com/amzxyz/rime-wanxiang)                         | 万象方案、配套脚本与配置文档          |
| [amzxyz/RIME-LMDG](https://github.com/amzxyz/RIME-LMDG)                                 | 万象语言模型与词库相关工作            |
| [yuanz-12/momo](https://github.com/yuanz-12/momo)                                       | 魔改墨奇码及本仓库构建采用的 Pro 词表 |
| [yuanz-12/wanxiang_yoemin](https://github.com/yuanz-12/wanxiang_yoemin)                 | 鸢鸣万象方案                          |
| [arsenali/rime-triple-pinyin-lssp](https://github.com/arsenali/rime-triple-pinyin-lssp) | 鸢鸣万象所基于的李氏三拼音码          |
| [gaboolic/moqima-tables](https://github.com/gaboolic/moqima-tables)                     | momo 所参考的原版墨奇拆分码表         |

此外，主题中的思无邪系列移植配色、背景、字体与图标等资源，其来源说明以对应文件注释和上游项目为准。

主题入口文件声明 `GPL-3.0-or-later`。上游方案、词库、模型、字体和图片等资源各自保留其作者信息与许可；本仓库的汇集和定制不改变这些资源的归属，也不意味着所有文件统一采用同一种许可证。使用或再分发时，请保留相应署名和许可声明。
