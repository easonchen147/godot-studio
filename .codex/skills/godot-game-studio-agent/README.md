# Game Studio Agent

Portable Codex skill for building first-playable games in Godot 4.7, Unity, and Unreal Engine 5.x with a professional studio-style role system.

This skill helps Codex detect the project engine, route work through directors, department leads, and specialists, create game production docs, manage ImageGen asset workflows, improve game feel, run playtest QA, and prepare engine-specific release checks.

## Features

- Godot, Unity, and Unreal project detection.
- GodotIQ MCP setup for Godot projects.
- Professional studio role routing: directors, leads, and specialists.
- First-playable production workflow.
- Genre templates for common game types.
- Game brief, development plan, asset list, and polish checklist generation.
- Game-feel guidance for controls, camera, feedback, UI, audio, and VFX.
- ImageGen-friendly art and asset pipeline.
- Engine-specific quality gates and release checks.
- Portable PowerShell scripts for Windows users.

## Support Matrix

| Engine | Detection | Starter docs | Project bootstrap | Editor automation |
| --- | --- | --- | --- | --- |
| Godot 4.7 | Yes | Yes | Production project shell | GodotIQ MCP when configured |
| Unity | Yes | Yes | Docs and folders only | Use editor/CLI logs when available |
| Unreal 5.x | Yes | Yes | Docs and folders only | Use commandlets/editor logs when available |

Unity and Unreal support intentionally avoids downloading or creating large editor projects automatically. Create or open those projects with official editor tooling, then use this skill for routing, docs, checks, and implementation guidance.

## Install

Clone this repository, then run:

```powershell
.\scripts\install-skill.ps1 -Force
```

By default, the installer copies the skill to:

- `CODEX_HOME\skills` when `CODEX_HOME` is set.
- `$HOME\.codex\skills` otherwise.

Restart Codex after installing or updating the skill.

## Detect A Project

```powershell
.\scripts\detect-game-engine.ps1 -ProjectPath "<project-root>"
.\scripts\check-engine-env.ps1 -ProjectPath "<project-root>"
```

Detection markers:

- Godot: `project.godot`
- Unity: `Assets/`, `Packages/manifest.json`, `ProjectSettings/ProjectVersion.txt`
- Unreal: `*.uproject`

## Start A New Game Project

Godot starter:

```powershell
.\scripts\start-game-project.ps1 -Engine godot -ProjectPath "<project-root>" -ProjectName "My Game" -Genre "2D platformer"
```

Unity or Unreal starter docs:

```powershell
.\scripts\start-game-project.ps1 -Engine unity -ProjectPath "<project-root>" -ProjectName "My Game" -Genre "top-down action"
.\scripts\start-game-project.ps1 -Engine unreal -ProjectPath "<project-root>" -ProjectName "My Game" -Genre "action RPG"
```

Unity and Unreal flows create production docs and folders but do not download or generate large editor projects automatically.

## Configure GodotIQ MCP

From a Godot project root:

```powershell
.\scripts\setup-godot-mcp.ps1 -ProjectPath "<project-root>" -InstallGodotIQ -InstallAddon
```

Restart Codex after changing MCP configuration.

## Use In Codex

Example prompts:

```text
Use $godot-game-studio-agent to detect this project's engine and route a first-playable plan through the studio roles.
```

```text
Use $godot-game-studio-agent to improve this Unity prototype's movement, camera, VFX, audio, UI, and QA loop.
```

```text
Use $godot-game-studio-agent to prepare an Unreal release checklist and engine-specific quality gate report.
```

## Studio Workflow

The skill routes work through a three-tier studio structure:

- Directors own scope, creative direction, technical risk, art, audio, QA, and release.
- Department leads own design, engine workflow, gameplay, UI/UX, levels, technical art, tools, performance, and narrative.
- Specialists own engine implementation, combat, systems, game feel, camera, VFX, materials, UI implementation, audio, QA, accessibility, export, and documentation.

Use `references/role-routing.md` for task routing and `references/role-quality-gates.md` for done criteria.

## Repository Layout

```text
SKILL.md
README.md
agents/
  roles/
references/
scripts/
```

## Requirements

- Codex with local skill support.
- Godot 4.7 for Godot projects.
- Unity Editor for Unity project checks.
- Unreal Engine 5.x for Unreal project checks.
- PowerShell on Windows.
- `uvx` for GodotIQ MCP setup.
- Optional: Node.js and Git for fallback tooling.

## Safety

The repository is intended to contain only portable skill source files, public documentation, and setup scripts. Do not commit local project files, generated images, credentials, local logs, or machine-specific configuration.
