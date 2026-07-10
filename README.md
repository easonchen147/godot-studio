# Godot Studio Starter 4.7

[![Godot](https://img.shields.io/badge/Godot-4.7-478cbf?logo=godot-engine&logoColor=white)](https://godotengine.org/)
[![Scope](https://img.shields.io/badge/scope-2D--first-2b8a3e)](#这个模板适合什么)
[![License](https://img.shields.io/badge/license-MIT-111827)](LICENSE)
[![Agent Ready](https://img.shields.io/badge/agent-ready-6d28d9)](AGENTS.md)

一个开箱即用、MIT 许可、面向 AI Agent 协作的 Godot 4.7 2D 游戏开发模板。

它不是庞大的通用框架，也不是“一键生成完整游戏”。它提供的是一套小而全的生产起点：可运行的第一可玩循环、生产级目录结构、项目内 Agent 技能、游戏设计文档、轻量 spec 机制、2D 素材管线、Shader/VFX 示例、测试/导出脚本、第三方组件目录和开源发布检查。

## 一张图看懂

| 层 | 解决什么 | 主要入口 |
| --- | --- | --- |
| Runtime | 复制后立刻能跑，有菜单、有第一可玩、有反馈闭环 | `game/boot/boot.tscn`、`game/app/`、`features/levels/level_001/` |
| Studio | 让游戏先有“灵魂”：玩家幻想、玩法、数值、关卡、素材和任务 | `docs/studio/` |
| Spec | 让迭代可追踪：当前权威文档、变更历史、组件级补充说明 | `docs/specs/spec-index.md`、`docs/specs/change-log.md` |
| Agent | 让 AI 知道如何开发 Godot 4.7 2D 游戏、何时查官方文档、如何验收 | `AGENTS.md`、`.codex/skills/` |
| Pipeline | 让素材、测试、导出和开源发布都有固定落点 | `assets/`、`tests/`、`tools/`、`docs/third_party/` |

核心原则：默认 vanilla Godot，默认 2D-first，默认小步可验证。只有当某个游戏真的需要时，才通过 ADR 引入更重的插件、3D、联网、外部 spec 流程或大型框架。

## 当前能力

| 能力 | 状态 |
| --- | --- |
| 引擎版本 | Godot 4.7 stable |
| 模板定位 | 2D-first，desktop-first 原型起点 |
| 主入口场景 | `res://game/boot/boot.tscn` |
| 运行流 | Boot -> AppShell -> MainMenu -> Sample Gameplay |
| 示例玩法 | 移动角色，收集 pickup，到达 goal，显示结果 |
| UI | 主菜单、选项、credits、暂停、结果、debug overlay |
| 全局服务 | `SignalBus`、`SettingsManager`、`GameState`、`AudioManager`、`SceneLoader` |
| 设置持久化 | `ConfigFile` + `user://` |
| 音频 | `audio_bus_layout.tres`，含 `Master`、`Music`、`SFX`、`UI`、`Ambience` |
| Theme | `shared/resources/studio_ui_theme.tres`，通过项目设置作为默认主题 |
| Shader/VFX | GDQuest MIT shader 子集 + `Shader Showcase` |
| 测试 | `tools/godot/run-tests.ps1` |
| Headless 加载 | `tools/godot/headless-check.ps1` |
| 导出 | Windows Desktop, Linux, and Web presets + `tools/godot/export-smoke.ps1` |
| Agent 工作流 | `.codex/skills/` 项目内 skills + `AGENTS.md` |
| Spec | `spec-index`、`change-log`、组件 spec 模板、ADR takeover rule |
| 许可证 | MIT |

已知环境要求：`tools/godot/export-smoke.ps1` 需要本机安装与所选 Windows Desktop、Linux 或 Web 预设匹配的 Godot `4.7.stable` export templates。如果模板缺失，脚本会在导出前明确报出缺少的文件。

## 这个模板适合什么

适合用 Godot 4.7 开发小型或中型 2D 游戏，尤其适合让 AI Agent 参与从创意、玩法、数值、关卡、素材、代码、QA 到导出的完整流程。

默认前提：

- 2D 游戏，desktop-first 原型。
- 主要代码语言是 typed GDScript。
- 默认节点体系是 `Node2D`、`Control`、`CharacterBody2D`、`Area2D`、`CollisionShape2D`、`Camera2D`、`TileMapLayer`。
- 默认 Shader 是 CanvasItem shader。
- 功能模块在 `features/` 内聚。
- 运行时素材放在 `assets/runtime/`。
- 可编辑源素材放在 `assets/source/`。
- 默认保持 vanilla Godot，不预装大型 editor plugin。

如果要加入 3D、2.5D、多人、联网服务、live-service 或大型第三方框架，先在 `docs/decisions/` 写 ADR，不要直接混入基础模板。

## 快速开始

1. 复制整个 `godot-studio/` 目录到新项目位置。
2. 重命名复制后的目录。
3. 如有需要，修改 `project.godot` 中的 `config/name`。
4. 用 Godot 4.7 打开这个目录。
5. 点击 Play。
6. 在主菜单选择 `Start Sample`。
7. 用 WASD 或方向键移动。
8. 收集黄色 pickup。
9. 到达绿色 goal。
10. 从主菜单打开 `Shader Showcase`，预览内置 GDQuest shader 子集。

短版入口文档见 `START_HERE.md`。完整开发流程以本文件为准。

## 第一次验证

在项目根目录运行：

```powershell
tools\godot\run-tests.ps1
tools\godot\headless-check.ps1
```

如果当前 PowerShell 策略禁止直接运行 `.ps1`，用一次性进程策略执行，不需要修改系统策略：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\godot\run-tests.ps1
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\godot\headless-check.ps1
```

测试通过时应看到：

```text
[tests] PASS: 103 checks
```

导出烟测：

```powershell
tools\godot\export-smoke.ps1
```

同样可以用 `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\godot\export-smoke.ps1` 运行导出烟测。

如果导出模板缓存不在默认目录：

```powershell
tools\godot\export-smoke.ps1 -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
```

Godot 4.7 官方文档确认点：

- 项目级 Theme 使用 `ProjectSettings.gui/theme/custom`。
- 玩家设置和存档使用 `user://`，可通过 `ConfigFile` 持久化。
- 命令行导出使用 Godot editor binary，常用组合是 `--headless --path . --export-release <preset> <output>`。

`headless-check.ps1` 内部同样执行 Godot 官方 `--headless --path <project> --quit`，但会把 `APPDATA` 和 `LOCALAPPDATA` 指向项目内 `.tmp-godot-user/`。这样可以避免本机 Godot 用户日志目录权限、锁定或污染影响模板验证。

## 目录结构

```text
game/                 引擎入口和全局运行时服务。
  boot/               项目入口场景。
  app/                AppShell，负责菜单、玩法和支持页面路由。
  main/               示例玩法组合，由 AppShell 加载，不是入口 owner。
  autoload/           SignalBus、SettingsManager、GameState、AudioManager、SceneLoader。

features/             产品功能。场景、脚本、本地资源放在一起。
  player/
  pickups/
  goals/
  levels/level_001/
  ui/
  vfx/shader_showcase/

shared/               跨功能复用代码。
  components/
  resources/
  states/
  utils/

assets/
  runtime/            Godot 运行时引用的引擎素材。
  source/             可编辑源素材，带 `.gdignore`，不参与 Godot 导入。
  import_presets/     导入设置和流程说明。

addons/               可选 Godot 插件。默认不安装大型插件。
tests/                项目内 Godot smoke runner。
tools/                CLI 包装脚本和自动化工具。
docs/                 规格、ADR、QA、研究、开源说明。
  studio/             游戏灵魂、玩法、数值、关卡、素材、调参、playtest、内容审计。
.codex/skills/        项目内 Agent 技能。
```

不要重新创建旧式根目录 `scenes/` 或 `scripts/`。

## 全流程开发方式

### 1. 先让 Agent 读项目契约

AI Agent 开始工作前先读：

- `AGENTS.md`
- `.codex/skills/godot-studio-project/SKILL.md`
- `.codex/skills/godot-2d-game-studio/SKILL.md`

按任务选择最小必要 skill：

| 任务 | Skill |
| --- | --- |
| 项目放置、验证、脚手架规则 | `.codex/skills/godot-studio-project/SKILL.md` |
| 2D 游戏创意、原型、专家团队流程 | `.codex/skills/godot-2d-game-studio/SKILL.md` |
| Godot 架构、场景、资源、autoload、导出 | `.codex/skills/godot/SKILL.md` |
| GDScript 实现和审查 | `.codex/skills/godot-gdscript/SKILL.md` |
| Shader、材质、VFX | `.codex/skills/godot-shader/SKILL.md` |
| C# 或原生扩展 | `.codex/skills/godot-csharp/`、`.codex/skills/godot-gdextension/` |

### 2. 遇到 Godot 问题时先查证

不要凭印象回答 Godot 4.7 问题。默认排查顺序：

1. 先读本地上下文：相关 `.gd`、`.tscn`、`.tres`、`project.godot`、`docs/specs/`。
2. 再查 Context7 官方文档：`/websites/godotengine_en_4_7`。
3. 再看项目内 Godot skill 的 `references/`。其中 4.6/4.5 内容只作为迁移风险提示；新增实现以 Context7 的 4.7 文档为准。
4. 再跑验证命令确认结论。

典型场景：

| 问题 | 默认动作 |
| --- | --- |
| API / 语法 / 引擎行为 | 先查 Context7 Godot 4.7，再改代码。 |
| UI 焦点、键盘/手柄导航 | 先查 Godot 4.7 UI 文档，再回到本地菜单场景。 |
| 导入、导出、渲染、输入映射、项目设置 | 先查 Context7，再跑 `tools/godot/*.ps1`。 |
| 项目结构、资源放置、玩法替换 | 先读 `AGENTS.md`、`docs/specs/architecture.md`、`docs/specs/dev-plan.md`。 |

模板内的完整研究/排障协议见 `docs/research/godot-problem-solving-protocol.md`。

### 3. 先定义游戏灵魂

新游戏不要直接改代码。先按顺序填写 `docs/studio/` 的第一层文档：

1. `docs/studio/brainstorm-log.md`
2. `docs/studio/grilling-gate.md`
3. `docs/studio/project-charter.md`
4. `docs/studio/gameplay-spec.md`
5. `docs/studio/balance-sheet.md`
6. `docs/studio/level-plan.md`
7. `docs/studio/asset-production-plan.md`
8. `docs/studio/implementation-tickets.md`

这些文档不要求写长。小项目可以每个文件只写关键结论。目标是让游戏有明确的玩家幻想、玩法循环、数值假设、关卡意图、素材需求和可实现任务。

### 4. 用生产 pass 推进游戏

当项目从想法进入反复迭代时，使用 `docs/studio/` 的第二层轻量模板：

| 文档 | 什么时候使用 |
| --- | --- |
| `system-sheet.md` | 单个机制、UI 流、敌人、经济、存档或反馈系统需要明确状态、规则、边界、验收。 |
| `level-slice.md` | 某一关、房间链、竞技场或教程路线需要 beat map、内容表、指标和 playtest 条件。 |
| `tuning-pass.md` | 一次聚焦调参需要记录假设、改动值、前后证据和回滚判断。 |
| `playtest-report.md` | 一次 playtest 需要沉淀观察、指标、问题和后续 tickets。 |
| `content-audit.md` | 里程碑、发布或开源前检查素材路径、许可、占位状态、`.import` 和生成目录。 |

这些文件是生产辅助层，不是文档负担。只有当它们能减少误解、返工或遗漏时才填写。

### 5. 同步核心规格

完成 `docs/studio/` 后，再更新：

- `docs/specs/spec-index.md`
- `docs/specs/game-brief.md`
- `docs/specs/gdd.md`
- `docs/specs/dev-plan.md`
- `docs/specs/architecture.md`
- `docs/specs/asset-list.md`
- `docs/specs/first-playable.md`
- `docs/specs/change-log.md`

本模板只内置最轻量的 spec 机制：

1. `docs/specs/spec-index.md`：告诉 Agent 当前哪些 spec 是权威文档。
2. `docs/specs/change-log.md`：记录每次有意义的设计、玩法、素材、QA、导出或架构变更。
3. `docs/specs/components/TEMPLATE.md`：当单个功能、系统、关卡、素材包或依赖决策写进主文档太长时，复制成一个短组件 spec。
4. 如果派生项目要换成另一套 spec 流程，先在 `docs/decisions/` 写 ADR，明确新的 source of truth，以及它如何映射回 Godot 的设计、素材、QA、发布文档。

使用规则：

| 情况 | 做法 |
| --- | --- |
| 小改、文案、数值微调 | 直接更新对应核心 spec；不新增组件 spec。 |
| 改玩法、关卡、素材、QA、导出或架构判断 | 更新对应核心 spec，并在 `docs/specs/change-log.md` 追加一条记录。 |
| 单个功能/系统/关卡/素材包说明过长 | 从 `docs/specs/components/TEMPLATE.md` 复制一个短组件 spec 到 `docs/specs/components/<topic>.md`，再从核心 spec 链过去。 |
| 引入 3D、联网、大型插件、外部 spec 流程或改变 Godot 版本 | 先在 `docs/decisions/` 写 ADR，再改实现。 |

不要为了形式新增一堆 spec 文件。日常迭代只用 `spec-index` 查入口、用 `change-log` 留历史；只有主文档装不下时，才加一个组件 spec。

### 6. 替换第一可玩循环

当前示例是 pickup-goal 循环。替换它时按这个顺序做：

1. 玩家移动或核心输入。
2. 一个会响应玩家行为的对象、敌人、pickup 或障碍。
3. 一个目标、计分、失败或重试条件。
4. HUD 只显示当前循环必要状态。
5. 行为、奖励、失败、成功都有视觉或音频反馈。
6. 第一关路线放在 `features/levels/level_001/`。
7. 更新测试和手动 playtest 路线。

功能文件保持内聚：

```text
features/my_feature/
  my_feature.tscn
  my_feature.gd
  local_resources.tres
  assets/
```

只有当第二个功能也需要同一段能力时，才把代码移动到 `shared/`。

### 7. 添加素材、声音、动画和 VFX

素材路径规则：

- 可编辑源文件：`assets/source/`
- Godot 运行时文件：`assets/runtime/`
- 资产登记表：`docs/specs/asset-list.md`
- 内容审计表：`docs/studio/content-audit.md`

2D 默认建议：

| 类型 | 建议 |
| --- | --- |
| Sprite / UI | PNG 或 WebP |
| 像素风 | Lossless 导入，避免 VRAM compression |
| 动画 | 优先 atlas 或 spritesheet |
| Tileset | tilesheet + `TileMapLayer` |
| 短音效 | WAV |
| 音乐、环境音、长音频 | OGG |
| 字体 | TTF/OTF，并记录许可 |
| Shader | `.gdshader`，使用 `shader_type canvas_item` |

Godot 导入运行时素材后，提交旁边生成的 `.import` sidecar。不要提交 `.godot/imported/`。

模板内置 GDQuest shader 子集：

- 运行时路径：`assets/runtime/shaders/gdquest/`
- 展示场景：`features/vfx/shader_showcase/shader_showcase.tscn`
- 第三方说明：`docs/third_party/gdquest-godot-shaders.md`

模板只导入 MIT shader source。上游 CC-BY-NC-SA 4.0 的图片、模型、字体等非商业素材没有导入。

### 8. 晚点再决定插件

基础模板默认不安装大型 Godot editor plugin。

需要插件时先读 `docs/third_party/plugin-catalog.md`。当前候选：

- GdUnit4：当前 smoke runner 不够时，引入完整测试框架。
- Phantom Camera：摄像机手感成为核心玩法时引入。
- Dialogue Manager 或 Dialogic：对话密集型游戏再引入。
- BehaviourToolkit 或 EasyStateMachine：本地状态机不足以支撑复杂敌人/NPC 行为时再引入。

提交插件前必须：

1. 确认 Godot 4.7 兼容。
2. 确认许可证兼容。
3. 记录 source、version、license 和启用原因。
4. 跑 `tools/godot/run-tests.ps1`。
5. 如果影响玩家体验，补充 playtest 步骤。

### 9. QA、Playtest 和调参

自动化测试：

```powershell
tools\godot\run-tests.ps1
tools\godot\headless-check.ps1
```

静态扫描：

```powershell
rg -n "Godot 4[.]6|res://scene[s]|res://script[s]|emit_signal[(]|[.]instance[(]|yield[(]" .
```

手动测试：

- 按 `docs/specs/qa/playtest-plan.md` 执行。
- 替换示例循环后，同步改写 playtest 路线。
- 一次 playtest 后填写 `docs/studio/playtest-report.md`。
- 一次聚焦调参后填写 `docs/studio/tuning-pass.md`。
- 记录玩家困惑、视觉可读性、反馈缺失、输入问题、素材缺口和性能问题。

不要在玩家能理解目标、执行核心动作、看到反馈并进入成功/失败/重试状态之前，宣称一个 playable slice 完成。

### 10. 导出

Windows Desktop、Linux 和 Web 导出预设都已提交到 `export_presets.cfg`。

运行：

```powershell
tools\godot\export-smoke.ps1
```

脚本会使用项目本地隔离的 Godot user data，并在导出前检查匹配的 export templates。如果缺失，安装 Godot 4.7 stable export templates，或传入 `-ExportTemplatesRoot`。

### 11. 开源发布

发布到 GitHub 前：

1. 阅读 `docs/open-source-audit.md`。
2. 使用 `docs/studio/content-audit.md` 做内容审计。
3. 确认 `LICENSE` 存在。
4. 确认第三方说明在 `docs/third_party/`。
5. 运行测试。
6. 运行凭据扫描工具。
7. 扫描本机用户路径。
8. 确认没有导入非商业素材。
9. 不提交 `.godot/`、`.tmp-godot-user/`、`build/`、`exports/`、`.import/`、导出证书。

## 派生游戏完成检查表

- [ ] `docs/studio/project-charter.md` 写清楚游戏灵魂。
- [ ] `docs/studio/gameplay-spec.md` 定义第一可玩。
- [ ] `docs/studio/balance-sheet.md` 记录数值假设和调参信号。
- [ ] `docs/studio/level-plan.md` 定义第一关。
- [ ] `docs/studio/asset-production-plan.md` 列出最小 2D 美术、音频、VFX。
- [ ] `docs/studio/system-sheet.md` 或组件 spec 覆盖复杂系统。
- [ ] `docs/studio/level-slice.md` 或组件 spec 覆盖进入生产的关卡。
- [ ] `docs/studio/playtest-report.md` 记录关键 playtest 结果。
- [ ] `docs/studio/tuning-pass.md` 记录关键调参证据。
- [ ] `docs/studio/content-audit.md` 完成发布前内容检查。
- [ ] `docs/studio/implementation-tickets.md` 把工作拆成可构建任务。
- [ ] `docs/specs/change-log.md` 记录关键迭代。
- [ ] `docs/specs/asset-list.md` 记录运行时素材和许可证。
- [ ] `docs/specs/qa/playtest-plan.md` 有可复现路线。
- [ ] `tools/godot/run-tests.ps1` 通过。
- [ ] `tools/godot/headless-check.ps1` 通过。
- [ ] 项目能在 Godot 4.7 打开并运行。
- [ ] 导出烟测通过，或明确记录本机 export templates 缺口。

## 许可证

本模板使用 MIT 许可证，见 `LICENSE`。

Godot Engine 没有被 vendored 到仓库中。GDQuest shader source 以其 MIT 许可说明导入；上游非商业美术和模型素材已明确排除。


## Continuous Delivery

- GitHub Actions validates the SceneTree runner and headless project load before exporting Windows Desktop, Linux, and Web artifacts.
- CI downloads pinned official Godot 4.7 stable archives and verifies them against the release SHA512 manifest before extraction.
- Local export smoke remains target-aware; a missing Linux template on Windows is a local prerequisite signal, while CI is the cross-platform authority.
