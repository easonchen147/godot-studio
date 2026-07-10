# Godot AI 全流程游戏开发模板

生成日期: 2026-07-08

适用范围: Godot 4.7 项目, 以 Codex/AI Agent 参与策划、工程、资源、关卡、调试、测试和发布全流程为前提。

核心目标: 不把 AI 当成“一键做游戏”的黑箱, 而是把 AI 纳入一个可验证、可回滚、可复用的 Godot 制作流水线。

---

## 1. 研究结论

Godot 适合 AI 辅助开发, 原因不是“AI 会做游戏”, 而是 Godot 的项目结构对 AI 友好:

- `.tscn`, `.tres`, `.gd`, `project.godot` 都是文本化资源, 便于 AI 读取、比较和修改。
- Godot 的核心抽象稳定: Scene, Node, Resource, Signal, Autoload, ProjectSettings。
- GDScript 的惯用写法集中, 比多框架混用的通用语言更适合生成和审查。
- 官方文档明确推荐以场景和节点树组织项目, 通过导入配置、导出预设、命令行导出和版本控制形成可自动化流程。

最佳实践不是“让 AI 连续生成完整游戏”, 而是:

1. 人类定义游戏愿景、核心乐趣、目标平台和验收标准。
2. AI 把目标拆成小的可运行任务。
3. 每个任务只改一个系统或一个场景边界。
4. Godot 编辑器/CLI/测试/日志验证后再进入下一步。
5. 重要决策写入项目上下文和决策记录, 不只保存在对话里。

本模板内置/建议使用的 Godot 相关 skill:

| Skill | 来源 | 用途 |
| --- | --- | --- |
| `godot` | `fetasty/godot-skills` | Godot 4.7 架构、场景/节点、信号、资源、autoload、项目设置、导出预设 |
| `godot-gdscript` | `fetasty/godot-skills` | 严格类型 GDScript、协程、状态机、Resource 模式、性能注意点 |
| `godot-csharp` | `fetasty/godot-skills` | Godot C# 项目、partial class、信号 delegate、async 模式 |
| `godot-gdextension` | `fetasty/godot-skills` | C++/Rust GDExtension、热路径、原生库、跨平台构建 |
| `godot-shader` | `fetasty/godot-skills` | Godot shader、渲染器差异、粒子、材质、后处理 |
| `godot-game-studio-agent` | `logi-cmd/godot-game-studio-agent` | Codex 驱动的游戏工作室流程、首个可玩版本、资源管线、QA、发布检查 |

建议后续工作方式:

- 做真实 Godot 项目时, 优先用 `$godot-game-studio-agent` 建立项目文档、角色分工、首个可玩版本和质量门。
- 写 Godot 代码时, 同时让 Codex 加载 `godot` 和对应语言 skill, 例如 `godot-gdscript`。
- 需要 shader 或性能热路径时, 再加载 `godot-shader` 或 `godot-gdextension`。

---

## 2. 资料来源整合

### 2.1 Godot 官方/Context7

从 Context7 获取的 Godot 官方资料给出以下硬规则:

| 主题 | 官方要点 | 在流程中的用法 |
| --- | --- | --- |
| 节点和场景 | 场景由节点树组成, 每个节点承担明确职责 | 所有功能先设计 scene tree, 再写脚本 |
| 项目组织 | 官方示例按模型、角色、关卡等目录组织资源 | 建立固定目录规范, 不让 AI 临时乱放文件 |
| 导入流程 | 资源导入会生成 `.import` 配置, 这些配置应进入版本控制 | 素材不是只提交源文件, 还要提交导入设置 |
| 导出流程 | `export_presets.cfg` 可提交, `.godot/export_credentials.cfg` 含敏感信息通常不提交 | CI/发布分离公开配置和私密凭据 |
| 命令行 | Godot 支持 `--headless --export-release` 等命令 | AI 可运行构建/导出验证 |
| 引擎架构 | 高层是 SceneTree/Node, 底层是渲染、音频、物理 server | 调试时区分脚本层、场景层和引擎 subsystem |

关键链接:

- Godot project organization: https://github.com/godotengine/godot-docs/blob/master/tutorials/best_practices/project_organization.md
- Nodes and scenes: https://github.com/godotengine/godot-docs/blob/master/getting_started/step_by_step/nodes_and_scenes.rst
- Import process: https://github.com/godotengine/godot-docs/blob/master/tutorials/assets_pipeline/import_process.md
- Exporting projects: https://github.com/godotengine/godot-docs/blob/master/tutorials/export/exporting_projects.md
- Command line tutorial: https://github.com/godotengine/godot-docs/blob/master/tutorials/editor/command_line_tutorial.md
- Godot architecture overview: https://github.com/godotengine/godot-docs/blob/master/engine_details/architecture/godot_architecture_diagram.md

### 2.2 本地 PDF 借鉴点

已阅读当前目录 7 份 PDF, 抽取结果位于 `.omx/tmp/pdf_extracts/`。

| PDF | 主题 | 纳入流程的借鉴 |
| --- | --- | --- |
| `GodotAI_2026-06-08.pdf` | 零基础 AI 辅助 2D 收集游戏 | 首个可玩版本应从简单核心循环开始, 用占位图形和最少场景验证玩法 |
| `GodotAI_2026-06-08 (1).pdf` | GDScript 专属 AI 提示词模板库 | 需要沉淀代码生成、审查、调试、系统开发、项目管理等提示词模板 |
| `GodotAI_2026-06-08 (2).pdf` | AI 写 GDScript 黄金法则 | 强制 Godot 4.7 语法、静态类型、`@onready`、Callable 信号、`@export` 可调参数 |
| `GodotAI_2026-06-09.pdf` | 敌人 AI: 巡逻、追逐、攻击、躲避 | 复杂玩法系统应先设计状态、感知、导航、调试可视化, 再生成代码 |
| `GodotAI_2026-06-10.pdf` | Godot 报错诊断 skill | 调试应按错误类型、位置、上下文、最小修复、回归验证执行 |
| `GodotAI_2026-06-12 (1).pdf` | 背包系统设计 | 数据用 `Resource`, 行为用系统/组件, UI 通过信号响应数据变化 |
| `GodotAI_2026-06-12.pdf` | AI 设计合理节点层级 | 节点树应模板化: World/UI/Systems 分层, 角色用 Components/States/Visuals 分区 |

PDF 对最终流程最有价值的共识:

- AI 生成前必须提供节点树、节点名称、信号、输入动作、资源路径和 Godot 版本。
- AI 输出代码必须严格 Godot 4.7, 不允许 Godot 3.x 的 `yield`, 旧 `connect`, `emit_signal`, `File`, `Directory`, 旧 `TileMap` API。
- 复杂系统优先拆为数据、状态、组件、UI、调试视图五部分。
- 每个系统都要有“可调参数”和“可视化/日志调试”入口。

### 2.3 BMAD Game Dev Studio

BMAD Game Dev Studio 适合做游戏开发的流程骨架:

- Product Research: 市场、竞品、定位。
- Game Design Document: 机制、进度、平衡。
- Narrative Design: 故事、角色、对话、世界观。
- UX Design: 视觉身份、HUD、输入、玩家旅程。
- Technical Architecture: 引擎模式、性能预算、项目结构。
- Production Planning: epic, sprint, story, retro。
- Quick Prototyping: 小项目或 game jam 先做可玩原型。

对 Godot 项目, BMAD 推荐先生成 `project-context.md`, 再做 `game-brief.md`, `gdd.md`, `architecture.md`, `sprint-status.yaml`, `stories/`。

关键链接:

- BMad Game Dev Studio GitHub: https://github.com/bmad-code-org/bmad-module-game-dev-studio
- BMad full docs for AI: https://docs.bmad-method.org/llms-full.txt
- BMGD docs: https://game-dev-studio-docs.bmad-method.org/
- BMGD workflows: https://game-dev-studio-docs.bmad-method.org/reference/workflows/
- BMGD Godot setup: https://game-dev-studio-docs.bmad-method.org/how-to/setup-godot/

### 2.4 Exa 全网调研结论

外部实践资料一致强调:

- AI agent 的价值在于读项目、理解 scene/script/resource/settings 的关系、分步计划、执行并验证, 不是只补全代码。
- 文件级 agent 可以编辑 `.gd`/`.tscn`, 但场景改动更适合通过 Godot 编辑器或 MCP/插件 API 验证。
- Godot 的 scene-node-script 三角结构让 AI 上下文更小, 但人类仍要把目标平台、输入动作、autoload 和 renderer 提前锁定。
- 不要一开始让 AI 生成完整游戏。应从真实节点和资源开始, 一次实现一个可运行功能, 每步提交。
- AI 强项是脚本、结构检查、数据集、调试、模板化系统。视觉确认、碰撞形状、TileSet/Terrain、手感、关卡节奏仍需要人工/运行时验证。

代表来源:

- Summer Engine Godot AI Agent Guide: https://www.summerengine.com/blog/godot-ai-agent-guide
- Antigravity + Godot solo workflow: https://antigravitylab.net/en/articles/app-dev/antigravity-godot-4-indie-game-development-guide
- Codex + Godot beginner workflow: https://knightli.com/en/2026/06/20/ai-codex-godot-game-development-beginner-guide/
- GodotPrompter skill framework: https://knightli.com/en/2026/06/13/godot-prompter-ai-agent-skills/
- Godot architecture for AI-assisted development: https://dev.to/ziva/why-godots-architecture-makes-it-the-best-engine-for-ai-assisted-development-5e8f

### 2.5 Skill Hub 调研

Skill Hub/SkillsMP 上找到的有用 Godot skill:

| Skill/仓库 | 用途 | 是否安装 | 判断 |
| --- | --- | --- | --- |
| `tinh2/skills-hub-registry` 的 `godot-scaffold` | 完整 Godot 4 项目脚手架, autoload, signal bus, state machine, save, export, CI/CD | 未安装 | 主要标注 Claude Code, 可作为脚手架参考 |
| `fetasty/godot-skills` | Codex Godot 4.7 技术 skill 集 | 已安装 | 本次首选, 原生匹配 Codex, MIT, 分工清晰 |
| `logi-cmd/godot-game-studio-agent` | Codex game studio 工作流、GodotIQ MCP、首个可玩版本、资源和 QA | 已安装 | 与本次“完整开发流程”目标高度一致 |
| `thedivergentai/GD-Agentic-Skills` | 大型 Godot skill 知识库, 90+ skills, genre blueprint | 未安装 | 内容大而全, 适合按需参考, 不建议一开始全量加载 |
| `shihabshahrier/Godot-Skill` | 单一 Godot/GDScript skill, 避免旧 API 和 AI 常见错 | 未安装 | 与 `fetasty` 的 `godot`/`godot-gdscript` 有命名和功能重叠 |
| `alexmeckes/godot-claude-skills` | Claude + godot-mcp 工作流 | 未安装 | 更偏 Claude ecosystem |
| `gigio1023/godot-best-practice` | Godot scene-as-code 和 Codex 指南 | 未安装 | 可后续评估, 当前不优先 |

---

## 3. 推荐总流程

### 两条路线

| 路线 | 适用情况 | 产物 | 节奏 |
| --- | --- | --- | --- |
| Quick Flow | game jam, 小原型, 想快速验证玩法 | `quick-spec.md`, first playable, asset list, polish checklist | 1-7 天 |
| Full Production | 商业项目、长期项目、团队协作 | `project-context.md`, `game-brief.md`, `gdd.md`, `narrative.md`, `architecture.md`, `stories/`, test plan | 多个 sprint |

建议默认:

- 新想法先 Quick Flow 做 first playable。
- 核心循环通过后, 再升级为 Full Production。
- 不要在乐趣未验证前投入精美美术、复杂叙事、联网、存档迁移、商城和平台 SDK。

---

## 4. 阶段 0: 环境和工程基线

目标: 让 Godot 项目从第一天开始可被 AI 正确读取、运行、导出和回滚。

### 输入

- Godot 版本, 建议 Godot 4.7 或团队统一版本。
- 是否使用 Standard 版或 .NET 版。
- 目标平台: PC, Web, Android, iOS, Steam, 主机。
- 渲染器: Forward+, Mobile, Compatibility。
- 语言选择: 默认 GDScript, 复杂工具/系统可选 C#, 热路径才用 GDExtension。

### 操作

1. 初始化 git。
2. 建立目录:

```text
res://
  project.godot
  export_presets.cfg
  addons/
  assets/
    art/
      concepts/
      sprites/
      tilesets/
      models/
      textures/
      ui/
      vfx/
    audio/
      music/
      sfx/
      ambience/
    fonts/
    shaders/
    source/
  scenes/
    main/
    levels/
    entities/
      player/
      enemies/
      pickups/
    ui/
    systems/
  scripts/
    autoloads/
    components/
    resources/
    states/
    utils/
  resources/
    configs/
    themes/
    data/
  tests/
  docs/
    decisions/
    design/
    qa/
```

3. 配置 `.gitignore`:

```gitignore
.godot/
*.tmp
*.translation
export_credentials.cfg
build/
exports/
```

4. 明确版本控制规则:

- 提交 `.gd`, `.tscn`, `.tres`, `project.godot`, `export_presets.cfg`。
- 提交源素材和 Godot 生成的 `.import` 配置。
- 不提交 `.godot/export_credentials.cfg`。
- 大型源素材使用 Git LFS 或外部资产库。

5. 配置基础输入动作:

```text
move_left, move_right, move_up, move_down
jump, attack, interact, dash
pause, inventory, confirm, cancel
```

6. 创建最小 autoload, 不要过早膨胀:

| Autoload | 是否默认创建 | 责任 |
| --- | --- | --- |
| `GameState` | 是 | 分数、关卡、游戏状态 |
| `SignalBus` | 中型项目后创建 | 跨系统事件, 不替代局部信号 |
| `AudioManager` | 有音频后创建 | 音量 bus、BGM、SFX 池 |
| `SaveManager` | 需要存档后创建 | 版本化存档、设置 |
| `SceneManager` | 多场景后创建 | 过场、异步加载 |

### AI 参与

调用:

```text
Use $godot-game-studio-agent to detect this project and create starter docs for a Godot first-playable workflow.
Use $godot to review project structure, autoload choices, export presets, and version-control rules.
```

### 验收

- Godot 能打开项目。
- 主场景能运行。
- `project.godot` 中输入动作存在。
- git status 只显示可解释文件。
- Codex 能根据目录结构说明每个系统在哪里。

---

## 5. 阶段 1: 游戏愿景和可玩核心

目标: 在写大量代码前定义“玩家做什么、为什么有趣、如何失败/成功”。

### 输出文件

`docs/game-brief.md`:

```markdown
# Game Brief

## Elevator Pitch

## Target Player

## Platform

## Genre

## Core Loop

1. Player action
2. System response
3. Reward / punishment
4. Next decision

## Unique Hook

## Art Direction

## Audio Direction

## Scope Limits

## First Playable Definition
```

`docs/design/core-loop.md`:

```markdown
# Core Loop

## 10-second loop

## 1-minute loop

## 10-minute loop

## Failure state

## Reward state

## What must be fun before production
```

### AI 参与

适合 AI:

- 生成多个玩法方向。
- 把一句话 idea 扩成 game brief。
- 做竞品/定位表。
- 提供风险清单。
- 生成 first playable 范围。

不适合 AI 独立决定:

- 最终核心乐趣。
- 美术审美方向。
- 商业定位。
- 是否砍功能。

### BMAD 对应

- Quick Flow: `quick-prototype`, `quick-spec`。
- Full Production: `brainstorm-game`, `game-brief`。

### 验收

- 一句话能说清游戏。
- 30 秒能说明核心操作。
- first playable 范围不超过 3 个主系统。
- 明确暂不做的内容。

---

## 6. 阶段 2: GDD、UX 和技术架构

目标: 把玩法、关卡、资源、UI、系统和工程边界写清楚, 避免 AI 每次重新猜。

### 关键产物

| 文件 | 内容 |
| --- | --- |
| `docs/project-context.md` | 项目单一事实源, 供 AI 每次读取 |
| `docs/gdd.md` | 机制、关卡、进度、平衡、失败/奖励 |
| `docs/narrative.md` | 世界观、角色、剧情、对话、任务 |
| `docs/ux.md` | 输入、HUD、菜单、玩家旅程、可访问性 |
| `docs/architecture.md` | 场景结构、脚本结构、信号、资源、autoload、性能预算 |
| `docs/asset-list.md` | 全部 UI/美术/音频/动画/模型需求 |
| `docs/qa/test-plan.md` | 测试、playtest、性能和平台矩阵 |

### `project-context.md` 模板

```markdown
# Project Context

## Godot Version

## Renderer

## Target Platforms

## Primary Language

## Project Structure

## Naming Rules

## Autoloads

## Input Map

## Physics Layers

## Scene Architecture

## Resource/Data Patterns

## UI Rules

## Art Pipeline

## Audio Pipeline

## Performance Budgets

## Export Presets

## AI Rules
- Always use Godot 4.7 syntax.
- Prefer strict typing.
- Prefer small scene/script changes.
- Read relevant scene and script before editing.
- Run parser/build/test after edits.
```

### Godot 架构决策

| 决策 | 默认建议 | 例外 |
| --- | --- | --- |
| 语言 | GDScript | 复杂业务系统可用 C#, 热路径可用 GDExtension |
| 场景组织 | 小而可复用 | 极简单 demo 可少量合并 |
| 继承 | 最多 2-3 层 | 引擎节点天然继承不算项目继承 |
| 组件 | 行为用子节点组件 | 纯数据不需要节点 |
| 数据 | `.tres` Resource | 大型表格可 CSV/JSON 后导入 Resource |
| 通信 | 局部 direct call + signal up | 跨系统才用 SignalBus |
| Autoload | 只放全局状态/服务 | 不要把所有 gameplay 放 autoload |
| UI | Control/Container/Theme | 不用硬编码坐标做正式 UI |

### 验收

- AI 读取 `project-context.md` 后能正确描述项目。
- 每个系统有所属目录和场景边界。
- 每个资源类型有源文件、导入设置和运行时路径。
- 每个目标平台有性能预算。

---

## 7. 阶段 3: First Playable

目标: 先做 1 分钟可玩体验, 不追求完整内容。

### First playable 最小组成

| 模块 | 最小要求 |
| --- | --- |
| 主场景 | 可启动, 可重开 |
| 玩家 | 可控制, 有碰撞, 有反馈 |
| 目标 | 能赢或完成一轮 |
| 失败 | 能输或受惩罚 |
| UI | 显示必要状态 |
| 音效 | 至少核心动作有反馈 |
| 占位资源 | 统一风格, 可替换 |
| 调试 | 可打印状态, 可复现问题 |

### 开发顺序

1. 创建主场景和玩家场景。
2. 设置输入动作。
3. 写玩家控制器。
4. 做一个可交互目标或敌人。
5. 做 HUD。
6. 加成功/失败条件。
7. 加最小音效/VFX。
8. 跑 5 次手动 playtest。

### AI 任务模板

```text
Context:
- Godot version: 4.x
- Scene: res://features/player/player.tscn
- Script: res://features/player/player.gd
- Input actions: move_left, move_right, jump

Task:
Implement a 2D platformer controller for CharacterBody2D.

Constraints:
- Use strict GDScript typing.
- Use ProjectSettings default gravity, not hardcoded gravity.
- Expose tunables with @export.
- Use _physics_process and move_and_slide().
- Include coyote time and jump buffer.
- Do not use Godot 3.x APIs.

Output:
- Patch the existing script only.
- Explain changed exported variables.
- Provide verification steps.
```

### 验收

- 玩家能完成一轮。
- 人类能说出“哪里好玩/哪里不好玩”。
- 当前问题能列入 backlog。
- 代码可以回滚。

---

## 8. 阶段 4: AI 开发循环

这是后续所有功能的固定循环。

### 单功能循环

1. 读上下文:
   - `project-context.md`
   - 相关 `.tscn`
   - 相关 `.gd`
   - 相关 `.tres`
2. 写 feature brief:
   - 目标
   - 输入
   - 输出
   - 场景节点变更
   - 信号变更
   - 数据变更
   - 验收标准
3. AI 生成小计划。
4. 人类或主 agent 审查计划。
5. 一次只改一个边界:
   - 数据 Resource
   - 组件脚本
   - 场景结构
   - UI
   - 测试
6. 运行验证:
   - Godot parse/build
   - 单元/集成测试
   - 手动 playtest
   - 日志检查
7. 提交或记录状态。
8. 更新文档和 asset list。

### 不允许的 AI 用法

- 没读现有场景就猜节点路径。
- 一次重写多个系统。
- 生成旧版 Godot API。
- 把全局状态随手塞入 autoload。
- 修改 `.tscn` 后不打开 Godot 验证。
- 只说“应该能运行”但不跑验证。
- 不理解错误就反复 regenerate。

---

## 9. GDScript 规则

### 必须遵守

```gdscript
class_name PlayerController
extends CharacterBody2D

@export var move_speed: float = 220.0
@export var jump_velocity: float = -380.0

@onready var sprite: Sprite2D = $Sprite2D

signal health_changed(current_health: int, max_health: int)

func _physics_process(delta: float) -> void:
    var direction: float = Input.get_axis("move_left", "move_right")
    velocity.x = direction * move_speed
    move_and_slide()
```

### 禁止/避免

| 错误 | 正确做法 |
| --- | --- |
| Godot 3 yield form | `await obj.signal` |
| string-named signal emission | `health_changed.emit(...)` |
| string-based button connection | `button.pressed.connect(_on_pressed)` |
| `File`, `Directory` | `FileAccess`, `DirAccess` |
| 旧 `TileMap` 作为新项目默认 | Godot 4.3+ 优先 `TileMapLayer` |
| 动态子节点用 `@onready` 硬拿 | 动态创建后显式赋值或 `get_node_or_null` |
| 物理回调里直接改监控/删除 | `call_deferred`, `set_deferred`, 或队列到下一帧 |
| 跨层 `$../../SomeNode` | exported NodePath, unique name, signal, 或注入引用 |

### 代码审查模板

```text
Review this Godot 4.7 GDScript.

Check:
- strict typing
- Godot 4 API only
- signal syntax
- node lifecycle and @onready timing
- physics safety
- scene coupling
- Resource/data separation
- performance in _process/_physics_process
- null/is_instance_valid checks

Return:
1. Bugs
2. Godot-specific risks
3. Minimal patch
4. Verification steps
```

---

## 10. 节点树和系统模板

### 顶层场景

```text
Game (Node)
  World (Node2D or Node3D)
    Environment
    Levels
    Entities
    Effects
  UI (CanvasLayer)
    HUD
    Menus
    Dialogs
  Systems (Node)
    RuntimeSpawner
    DebugOverlay
```

### 玩家场景

```text
Player (CharacterBody2D)
  CollisionShape2D
  Visuals (Node2D)
    Sprite2D or AnimatedSprite2D
    AnimationPlayer
    GPUParticles2D
  Components (Node)
    HealthComponent
    MovementComponent
    CombatComponent
    InventoryComponent
  States (Node)
    IdleState
    MoveState
    AttackState
  Debug (Node2D)
```

### 敌人 AI

敌人 AI 不应直接生成一大坨脚本。按以下结构拆:

| 子系统 | 责任 |
| --- | --- |
| `PerceptionComponent` | 检测范围、视野、听觉、目标记忆 |
| `NavigationAgent2D/3D` | 路径追踪 |
| `StateMachine` | Idle, Patrol, Chase, Attack, Flee, Search |
| `CombatComponent` | 攻击范围、冷却、伤害 |
| `DebugOverlay` | 显示状态、检测半径、路径 |

### 背包系统

```text
ItemData (Resource)
  id
  display_name
  description
  icon
  item_type
  max_stack
  stats

InventorySlot (Resource)
  item
  amount
  slot_changed

InventoryComponent (Node)
  slots
  add_item()
  remove_item()
  inventory_changed

InventoryUI (Control)
  GridContainer
  SlotViews
```

原则:

- 物品定义用 Resource。
- 背包槽也可用 Resource。
- 角色持有 InventoryComponent。
- UI 只展示和发出交互意图, 不直接拥有真实数据。
- 保存时保存 item id 和数量, 不保存临时节点引用。

---

## 11. 资源管线

### 总原则

所有资源都走同一个四步:

1. Brief: 用途、风格、尺寸、格式、命名、导入设置、验收标准。
2. Generate/Source: AI 生成、手绘、购买、录制、建模、开源素材。
3. Normalize: 裁剪、命名、透明通道、循环点、压缩、切帧、单位比例。
4. Import/Bind/Verify: 导入 Godot, 提交 `.import`, 绑定到场景, 运行验证。

### 资源目录

```text
assets/source/art/          # PSD/Krita/concept/reference art
assets/source/aseprite/     # editable animation sources
assets/source/audio/        # DAW sessions, recordings, stems
assets/source/blender/      # optional 2.5D/3D source files after ADR approval
assets/source/references/   # mood boards and external references

assets/runtime/sprites/     # 2D sprites, atlases, animation frames
assets/runtime/tilesets/    # tilesheets and TileSet inputs
assets/runtime/textures/    # masks, shared textures, material inputs
assets/runtime/ui/          # icons, panels, cursors, HUD art
assets/runtime/vfx/         # flipbooks, particles, effect sprites
assets/runtime/shaders/     # Godot .gdshader files
assets/runtime/audio/music/
assets/runtime/audio/sfx/
assets/runtime/audio/ambience/
assets/runtime/fonts/
assets/runtime/models/      # optional 2.5D/3D runtime models after ADR approval
assets/import_presets/      # import recipes and naming rules
```

### UI 素材

流程:

1. 先做 UX flow, 不先做美术。
2. 用 Godot `Control` 和 Container 完成布局。
3. 建立 Theme。
4. 生成/绘制 icon, panel, button state。
5. 接入键鼠/手柄/触屏导航。
6. 做多分辨率和语言长度检查。

AI 可做:

- HUD 草案。
- UI 文案。
- icon prompt。
- Theme token 表。
- 可访问性检查。

人工必须验:

- 手柄焦点顺序。
- 小屏文字溢出。
- 色弱/对比度。
- 真实操作是否顺手。

### 2D 精灵和动画帧

流程:

1. 概念图: 确定比例、轮廓、色板。
2. Sprite sheet: idle/run/jump/attack/hit/death。
3. 切帧: 固定 frame size 和 pivot。
4. Godot 导入: 纹理过滤、mipmap、repeat、compression。
5. 动画: `AnimatedSprite2D`, `AnimationPlayer`, 或 `AnimationTree`。
6. 状态绑定: 状态机只触发动画名, 不直接改帧。

AI prompt 模板:

```text
Create a sprite-sheet brief for:
- character role:
- camera:
- art style:
- frame size:
- animations:
- frames per animation:
- palette:
- negative constraints:
- Godot import notes:
```

### TileSet 和关卡图块

流程:

1. 先定义 tile size, 例如 16x16 或 32x32。
2. 生成 tile atlas: 地面、墙、边缘、角、装饰、危险物。
3. 在 Godot 设置 `TileSet`, `TileMapLayer`, collision, navigation, terrain。
4. 让 AI 设计关卡结构前, 先给它 tile id/语义表。
5. 关卡必须验证连通性、可达性、镜头边界、出生点和退出点。

### 音频素材

流程:

1. Audio direction: 情绪、节奏、参考、禁用风格。
2. 占位音效: UI click, pickup, hit, jump, confirm, fail。
3. BGM: loop point, intro, combat layer。
4. Godot bus: Master, Music, SFX, UI, Ambience。
5. 运行时: `AudioStreamPlayer`, `AudioStreamPlayer2D`, `AudioStreamPlayer3D`。
6. 保存音量设置。

注意:

- 节奏游戏或严肃同步场景要用 `AudioServer.get_time_since_last_mix()` 和输出延迟补偿思路。
- SFX 需要池化, 不要频繁创建销毁播放器。
- 音效命名要反映动作和材质, 例如 `sfx_player_jump_soft_01.wav`。

### 3D 建模和材质

流程:

1. Blockout: Godot CSG 或简单 mesh 先验证尺度。
2. Blender 建模: 单位、原点、朝向、命名。
3. 导出 GLB/GLTF。
4. PBR 贴图: BaseColor, Normal, ORM, Emission。
5. Godot 导入: scale, animation, material, collision。
6. 碰撞:
   - 角色用 capsule/convex。
   - 静态场景用 simplified collision。
   - 不直接用高模网格做复杂碰撞。
7. 性能:
   - LOD。
   - Occlusion。
   - MultiMesh。
   - 光照烘焙或 GI 方案。

AI 可做:

- Blender 资产 brief。
- 低模/模块化套件清单。
- 材质命名和贴图清单。
- Godot import checklist。

人工必须验:

- 尺寸和碰撞。
- 透视、遮挡、导航。
- 移动端渲染预算。

### Shader/VFX

默认路线:

- 命中反馈: hit flash shader + tween。
- 移动反馈: dust particles。
- 攻击反馈: slash trail / impact particles。
- UI feedback: button hover/click/tween。
- 环境反馈: light flicker, fog, wind, water。

调用:

```text
Use $godot-shader to write a Godot 4 canvas_item hit-flash shader with exported uniforms and a GDScript tween integration example.
```

---

## 12. 关卡设计流程

关卡设计不能只让 AI “生成地图”。应按可验证设计流推进。

### 关卡 brief

```markdown
# Level Brief

## Level ID

## Player Skill Tested

## New Mechanic

## Required Assets

## Critical Path

## Optional Path

## Difficulty Curve

## Enemy / Hazard Placement Rules

## Camera Rules

## Checkpoints

## Success Criteria

## Failure Criteria
```

### 开发顺序

1. 纸面/文本结构:
   - 起点
   - 教学段
   - 练习段
   - 变化段
   - 压力段
   - 奖励
   - 终点
2. Blockout:
   - 灰盒。
   - 只用基础碰撞。
   - 不上精美资源。
3. Metrics pass:
   - 跳跃距离。
   - 移动速度。
   - 视野。
   - 敌人反应时间。
4. Playtest:
   - 首次通过率。
   - 死亡点热区。
   - 迷路点。
   - 操作误解。
5. Art pass:
   - 视觉引导。
   - 背景层次。
   - 装饰密度。
6. Performance pass:
   - draw calls。
   - collision count。
   - navigation cost。
   - shader cost。

### AI 可做

- 关卡结构草案。
- TileMapLayer 填充建议。
- 敌人/奖励分布。
- 可达性检查脚本。
- Playtest 问卷。

### AI 不应单独决定

- 乐趣是否成立。
- 难度是否公平。
- 空间尺度是否舒服。
- 美术阅读是否清晰。

---

## 13. 测试、调试和质量门

### 日常验证顺序

1. 语法/加载:
   - 打开 Godot。
   - 看 Output/Debugger。
   - 确认主场景加载。
2. 功能:
   - 手动执行新功能路径。
   - 检查输入、信号、UI、保存。
3. 自动测试:
   - GUT 或项目选定测试框架。
   - 关键纯逻辑用单元测试。
4. 性能:
   - Godot profiler。
   - Monitor: FPS, frame time, objects, draw calls, memory。
5. 导出:
   - debug export。
   - release export。
   - 平台 smoke test。

### Godot CLI

示例:

```powershell
godot --headless --path . --quit
godot --headless --path . --export-release "Windows Desktop" build/game.exe
godot --headless --path . --export-release "Android" build/game.apk
```

具体 preset 名称必须与 `export_presets.cfg` 一致。

### 错误诊断模板

```text
Diagnose this Godot 4.7 error.

Error:
<full output>

Context:
- changed files:
- scene being run:
- Godot version:
- platform:

Required process:
1. classify error: parse/load/runtime/physics/resource/signal/export
2. identify exact failing file/node/signal/resource
3. propose the smallest fix
4. explain why this happens in Godot
5. give regression check
```

### 常见错误清单

| 症状 | 常见原因 | 修复方向 |
| --- | --- | --- |
| `Node not found` | 节点路径错, 动态节点未创建, 场景结构变更 | `@onready`, `%UniqueName`, `get_node_or_null`, 更新路径 |
| `Invalid call` | 方法不存在, Godot 版本错, 类型错 | 查官方文档/skill, 加类型, 改 API |
| `Can't change this state while flushing queries` | 物理回调中改物理状态 | `call_deferred`, 队列到下一帧 |
| signal connect failed | 旧 connect 语法或方法名不匹配 | Callable connect, 检查 handler 签名 |
| missing resource | 路径错, 文件未提交, import 配置缺失 | 统一 `res://`, 提交源文件和 `.import` |
| export missing credential | 敏感凭据未复制 | 本地配置 `.godot/export_credentials.cfg`, 不提交 |

### 性能预算模板

| 平台 | FPS | CPU frame | GPU frame | 内存 | 备注 |
| --- | --- | --- | --- | --- | --- |
| PC | 60/120 | 16.6ms/8.3ms | 16.6ms/8.3ms | 项目定义 | 默认 |
| Mobile | 30/60 | 33ms/16.6ms | 33ms/16.6ms | 严格限制 | 控制粒子/灯光/后处理 |
| Web | 30/60 | 33ms/16.6ms | 33ms/16.6ms | 浏览器限制 | 控制包体和加载 |

---

## 14. 发布流程

### 发布前检查

| 项 | 检查 |
| --- | --- |
| 版本 | `project.godot` 版本号, changelog |
| 导出预设 | `export_presets.cfg` 已更新 |
| 凭据 | 本机存在, 不提交 |
| 存档 | 旧版本迁移测试 |
| 输入 | 键鼠/手柄/触屏 |
| UI | 分辨率, 语言长度, 安全区 |
| 性能 | 目标平台 profiler |
| 音频 | 音量默认值, 静音, bus |
| 法务 | 素材授权, 字体授权, 第三方 license |
| 崩溃 | 冷启动、重开、暂停、切后台 |

### 构建产物目录

```text
build/
  windows/
  linux/
  macos/
  web/
  android/
release-notes/
  0.1.0.md
```

### CI 建议

最低 CI:

- 检查 Godot 可打开项目。
- 运行脚本/单元测试。
- 导出 debug build。
- 上传 artifact。

成熟 CI:

- 多平台导出。
- 自动 itch.io/Steam beta 发布。
- 资源大小检查。
- License 清单。
- 保存文件迁移测试。

---

## 15. AI 提示词模板库

### 15.1 功能开发

```text
You are working in a Godot 4.7 project.

Read:
- docs/project-context.md
- <scene paths>
- <script paths>

Feature:
<one feature>

Constraints:
- strict typing
- Godot 4.7 API only
- no broad rewrites
- keep scene responsibility clear
- expose tuning values with @export
- use signals for upward events
- add debug visibility if useful

Deliver:
1. plan
2. patch
3. verification command / manual test
4. risks
```

### 15.2 节点树设计

```text
Design a Godot scene tree for:
<system or entity>

Include:
- root node type and responsibility
- child nodes
- scripts attached
- signals
- exported properties
- resources used
- debug nodes
- what should NOT be in this scene

Keep it compositional and reusable.
```

### 15.3 资源生成 brief

```text
Create an asset brief for Godot.

Asset:
Purpose:
Style:
Camera/view:
Size:
Format:
Animations:
Variants:
Import settings:
Runtime path:
Acceptance criteria:
Negative constraints:
```

### 15.4 关卡设计

```text
Design a Godot level blockout.

Game:
Core mechanic:
Player metrics:
Available tiles/assets:
Enemies/hazards:
Target duration:
Difficulty:

Return:
- level beats
- rough map layout
- object placement
- camera constraints
- playtest checklist
- Godot implementation notes
```

### 15.5 代码审查

```text
Review this Godot change.

Focus on:
- Godot 4.7 API correctness
- scene/node/resource boundaries
- signals and lifecycle
- static typing
- physics safety
- performance in process loops
- export/platform risk
- missing tests or playtest steps

Output findings first, ordered by severity.
```

---

## 16. Skill 调用策略

| 任务 | 推荐 skill |
| --- | --- |
| 新建 Godot 项目/首个可玩版本 | `$godot-game-studio-agent` |
| 架构、目录、autoload、资源、导出 | `$godot` |
| GDScript 实现/审查 | `$godot-gdscript` |
| C# 系统 | `$godot-csharp` |
| Shader/VFX | `$godot-shader` |
| 性能热路径、原生扩展 | `$godot-gdextension` |
| UI/网页工具或外部工具页面 | `frontend-design` 或现有 UI skill |
| 图片素材生成 | `imagegen` |
| 调试困难 bug | `diagnose` + `$godot`/`$godot-gdscript` |
| 大型方案规划 | `plan` / `ralplan` |
| 外部官方文档 | `context7-mcp` |

注意: 新安装 skill 需要重启 Codex 后才会进入自动可用列表。

---

## 17. 每个阶段的 Definition of Done

### Concept Done

- 有 `game-brief.md`。
- 有核心循环。
- 有目标平台。
- 有 first playable 定义。

### Architecture Done

- 有 `project-context.md`。
- 有目录结构。
- 有 scene/resource/signal/autoload 规则。
- 有性能预算。
- 有导出策略。

### Feature Done

- 功能可在 Godot 中运行。
- 相关场景和脚本边界清楚。
- 有最小测试或手动验证记录。
- 没有新增未解释错误。
- 文档/asset list 已更新。

### Asset Done

- 源文件已保存。
- Godot 运行时资源已导入。
- `.import` 已提交。
- 命名和路径符合规范。
- 运行场景中可见/可听/可交互。

### Level Done

- 可从起点到终点完成。
- 有失败/重试路径。
- 摄像机和 UI 不遮挡关键内容。
- 性能达标。
- 至少一次外部 playtest 或自测记录。

### Release Done

- 目标平台导出成功。
- 存档/设置/输入/UI 通过 smoke test。
- release notes 完成。
- 第三方 license 清单完成。

---

## 18. 推荐落地顺序

如果从下一个 Godot 项目开始, 按这个顺序执行:

1. 重启 Codex, 让新安装的 Godot skills 生效。
2. 创建 Godot 项目, 初始化 git。
3. 调用 `$godot-game-studio-agent` 生成 starter docs。
4. 写 `project-context.md`, `game-brief.md`, `asset-list.md`。
5. 只做 first playable:
   - 主场景
   - 玩家
   - 一个目标
   - 一个失败条件
   - HUD
   - 最小音效/反馈
6. 每个功能用“读上下文 -> 小计划 -> 小 patch -> Godot 验证 -> 提交”循环。
7. first playable 好玩后再扩:
   - 关卡 1
   - 核心敌人/障碍
   - 资源替换
   - 存档
   - 菜单
   - 发布管线
8. 进入 BMAD Full Production:
   - GDD
   - Architecture
   - Sprint
   - Story
   - QA
   - Retrospective

---

## 19. 最小首周计划

### Day 1: 项目基线

- Godot 项目创建。
- git 初始化。
- 输入动作。
- 目录结构。
- `project-context.md`。
- `game-brief.md`。

### Day 2: 玩家和核心交互

- Player scene。
- 控制器。
- 摄像机。
- 第一个可交互对象。

### Day 3: 游戏循环

- 成功条件。
- 失败条件。
- HUD。
- 重开流程。

### Day 4: 资源占位和反馈

- placeholder sprites。
- SFX。
- hit/pickup/complete feedback。
- 最小 shader/particle。

### Day 5: 第一个关卡

- blockout。
- TileMapLayer 或 3D greybox。
- 引导路径。
- 难度变化。

### Day 6: QA 和修复

- 错误日志清理。
- 手感调整。
- 性能检查。
- bug list。

### Day 7: first playable 决策

- 是否继续。
- 保留/砍掉哪些机制。
- 下个 sprint stories。
- 资源制作清单。

---

## 20. 关键风险和防护

| 风险 | 防护 |
| --- | --- |
| AI 生成过时 Godot API | 加载 `godot`/`godot-gdscript`, 明确 Godot 版本, 查 Context7 |
| 节点路径幻觉 | 让 AI 先读 `.tscn`, 提供节点树, 使用 unique names/exported paths |
| 大改导致不可回滚 | 小 patch, 每步验证, git commit |
| 美术先行浪费 | first playable 前只用占位资源 |
| 复杂 autoload 变全局泥潭 | autoload 只放真正全局服务 |
| `.tscn` 文本编辑损坏 | 优先编辑器/MCP, 文件级改动后打开 Godot 验证 |
| 手感不佳但代码看似正确 | 人工 playtest, 参数暴露到 inspector |
| 关卡不可达/难度乱 | blockout, metrics, 可达性检查 |
| 存档后期不可迁移 | 一开始加 save version |
| 平台导出临近发布才发现问题 | 早期建立 export preset 和 smoke export |

---

## 21. 附录: 本次研究产物

本次研究生成/更新:

- `GODOT_AI_GAME_DEV_PLAYBOOK.md` - 本文档。
- `.omx/specs/autoresearch-godot-ai-dev/mission.md` - autoresearch 任务定义。
- `.omx/specs/autoresearch-godot-ai-dev/sandbox.md` - 研究边界。
- `.omx/specs/autoresearch-godot-ai-dev/result.json` - 验证结果。
- `.omx/tmp/pdf_extracts/` - 7 份 PDF 的文本提取结果。

已安装 skill:

- `<CODEX_HOME>\skills\godot`
- `<CODEX_HOME>\skills\godot-gdscript`
- `<CODEX_HOME>\skills\godot-csharp`
- `<CODEX_HOME>\skills\godot-gdextension`
- `<CODEX_HOME>\skills\godot-shader`
- `<CODEX_HOME>\skills\godot-game-studio-agent`
