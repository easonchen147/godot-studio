# Installation And Engine Setup

Use this reference when setting up or repairing the Codex game studio toolchain for Godot, Unity, or Unreal. All commands are portable; pass explicit paths when auto-detection is not enough.

## Detect The Environment

Run:

```powershell
& "<skill-root>\scripts\detect-game-engine.ps1" -ProjectPath "<project-root>"
& "<skill-root>\scripts\check-engine-env.ps1" -ProjectPath "<project-root>"
```

Engine detection:

- Godot: `project.godot`
- Unity: `Assets/`, `Packages/manifest.json`, `ProjectSettings/ProjectVersion.txt`
- Unreal: `*.uproject`

Godot executable discovery order:

- `-GodotPath`
- `GODOT4_PATH`
- `GODOT_PATH`
- `godot` or `godot4` on `PATH`
- common Windows install folders and portable Godot folders

If the project is on a UNC path, prefer passing absolute paths to tools. If a tool launched through `cmd.exe` fails on UNC current directories, map or use an existing drive path before retrying.

## Initialize A Project

For a game-ready starter with docs and production folders:

```powershell
& "<skill-root>\scripts\start-game-project.ps1" -Engine godot -ProjectPath "<project-root>" -ProjectName "My Game" -Genre "2D platformer" -TargetPlatform "desktop" -Perspective "2D"
```

Use `-Engine unity` or `-Engine unreal` to create production docs and starter folders for those engines. The script does not download or generate large Unity/Unreal project files automatically; use official editor tooling for that step.

The starter flow creates:

- `docs/game-brief.md`
- `docs/dev-plan.md`
- `docs/asset-list.md`
- `docs/polish-checklist.md`
- starter folders for `game/`, `features/`, `shared/`, `assets/source/`, `assets/runtime/`, `docs/`, `tests/`, `tools/`, and exports

For only a minimal Godot 2D project:

```powershell
& "<skill-root>\scripts\new-godot-project.ps1" -ProjectPath "<project-root>" -ProjectName "My Godot Game"
```

This creates:

- `project.godot` with `run/main_scene`
- `game/main/main.tscn`
- `game/main/main.gd`
- `features/` for gameplay, UI, and level modules
- `shared/` for reusable components, Resources, states, and utilities
- `assets/source/` for editable sources
- `assets/runtime/` for runtime assets
- `docs/`, `tests/`, `tools/`, and `exports/`

## Install GodotIQ MCP

GodotIQ is the primary Godot MCP because it documents Codex TOML setup directly.

Install or run through `uvx`:

```powershell
uvx godotiq --help
```

Codex config:

```toml
[mcp_servers.godotiq]
command = "uvx"
args = ["godotiq"]

[mcp_servers.godotiq.env]
GODOTIQ_PROJECT_ROOT = "<absolute-project-root>"
```

Configure it with:

```powershell
& "<skill-root>\scripts\setup-godot-mcp.ps1" -ProjectPath "<project-root>" -InstallGodotIQ -InstallAddon
```

After editing the Codex config file, restart Codex so the MCP server is loaded.

## Install The Godot Addon

If GodotIQ bridge tools require the editor addon, run the provider's addon installer from the project root:

```powershell
$env:PYTHONUTF8 = "1"
uvx godotiq install-addon "<project-root>"
```

Then open Godot and enable the addon if prompted. If the command fails, capture the error and continue with file-level Codex edits plus runtime checks until the bridge is repaired.

On Windows, keep `PYTHONUTF8=1` for this command. Without it, some Python environments may fail while reading GodotIQ's bundled rule files under a non-UTF-8 console code page.

## Fallback MCP And Editor Bridges

If GodotIQ is unavailable for Godot, use an open-source Godot MCP server:

- `bradypp/godot-mcp`: Node/TypeScript server for launching projects, scene operations, debug output, and project metadata.
- Godot 4.7-compatible MCP variants with an editor addon can inspect and modify the live scene tree.

Fallback Codex shape:

```toml
[mcp_servers.godot]
command = "node"
args = ["<absolute-path-to-godot-mcp>/build/index.js"]

[mcp_servers.godot.env]
GODOT_PATH = "<absolute-path-to-godot-executable>"
READ_ONLY_MODE = "false"
```

Build fallback servers exactly as their README specifies before adding them to Codex.

For Unity and Unreal, use editor bridges, CLI/editor logs, or user-provided Console/Output Log evidence when available. This skill does not assume Unity or Unreal automation exists until `check-engine-env.ps1` or active tools confirm it.
