---
name: godot-game-studio-agent
description: Set up and operate a Codex-driven game studio workflow for Godot 4.7, Unity, and Unreal Engine 5.x with professional role routing, engine detection, ImageGen asset generation, game brief intake, genre templates, first-playable production, game-feel polish, engine-specific run/debug loops, playtest QA, and export preparation. Use when the user asks to create, configure, automate, debug, polish, or iterate on a Godot, Unity, or Unreal game through Codex, MCP/editor tools, generated art assets, or a multi-role Game Studio agent process.
---

# Game Studio Agent

## Overview

Use this skill to turn Codex into a practical game studio operator for Godot 4.7, Unity, and Unreal Engine 5.x projects. It is designed as a portable release package: detect the local game engine, initialize or document a project when needed, configure available MCP/editor bridges, route work through professional studio roles, and verify output with engine-specific quality gates.

The production target is not merely "runs without errors." The default target is a small, playable, readable, and satisfying first version with clear player intent, responsive controls, visible feedback, coherent art direction, useful UI, and a repeatable playtest path.

Godot is the most complete first-class engine path because it includes project bootstrap and GodotIQ MCP setup. Unity and Unreal support include project detection, role routing, design docs, engine-specific workflow guidance, quality gates, and environment checks; editor bridge automation is optional and should be used when available.

## Quick Start

1. Detect the project engine with `scripts/detect-game-engine.ps1`.
2. Inspect installed tooling with `scripts/check-engine-env.ps1`.
3. If starting fresh, use `scripts/start-game-project.ps1 -Engine godot|unity|unreal` or this scaffold's production layout to create the project structure and starter design docs.
4. For Godot projects, configure Codex MCP with `scripts/setup-godot-mcp.ps1`; use GodotIQ first.
5. Restart Codex after changing the Codex config file so new MCP tools can load.
6. Route work through `references/role-routing.md`, then use `references/engine-workflows.md` and `references/role-quality-gates.md` for implementation and verification.

## Workflow

- **Install or repair tooling:** Read `references/install.md`, run `scripts/check-engine-env.ps1`, configure GodotIQ for Godot when needed, and use Unity/Unreal editor logs or bridges only when available.
- **Start a game:** Detect or choose the engine, read `references/game-brief.md`, choose a shape from `references/genre-templates.md`, then generate `docs/game-brief.md`, `docs/dev-plan.md`, `docs/asset-list.md`, and `docs/polish-checklist.md`.
- **Route the studio:** Read `references/studio-structure.md` and `references/role-routing.md`; load only the director, lead, and specialist role cards needed for the task.
- **Build a first playable:** Read `references/first-playable.md`, `references/engine-workflows.md`, and `references/team-workflows.md`. Deliver a complete minute-one experience before expanding scope.
- **Improve game effect:** Use `references/game-feel.md` for controls, feedback, camera, animation, hit effects, UI clarity, pacing, sound, and juice.
- **Create visual assets:** Invoke the `imagegen` skill for concept art, textures, sprites, UI mockups, icons, or placeholders. Use `references/asset-pipeline.md`, save project-bound images inside the project, then import or bind them through the selected engine's scenes, prefabs, blueprints, resources, materials, or UI.
- **Debug and playtest:** Prefer real editor/runtime feedback over guessing. Read scene state, run the project, inspect logs, use `references/playtest-qa.md` and `references/role-quality-gates.md`, make one focused fix, and rerun.
- **Prepare release:** Use `references/release.md` when packaging this skill for another Codex installation.

## Common Prompts

```text
Use $godot-game-studio-agent to detect this project's engine and route a first-playable plan through the studio roles.
```

```text
Use $godot-game-studio-agent to improve this Unity prototype's feel: movement, attack feedback, camera, audio, and UI.
```

```text
Use $godot-game-studio-agent to prepare an Unreal first playable using the action RPG route and engine-specific QA gates.
```

## Defaults

- Engine detection: `project.godot` for Godot, Unity project markers for Unity, `.uproject` for Unreal, otherwise `unknown`.
- Godot target for this scaffold: 4.7. Verify version-sensitive behavior through Context7 `/websites/godotengine_en_4_7`.
- Project root: current folder containing engine markers, or a user-provided absolute path.
- Godot MCP: `godotiq` via `uvx godotiq`
- Unity/Unreal editor bridge: optional; use CLI/editor logs and user-provided output when no bridge is available.
- Codex MCP config: `-CodexConfig`, then `CODEX_HOME\config.toml`, then `$HOME\.codex\config.toml`
- Generated art: `assets/source/` for editable sources and `assets/runtime/` for imported runtime assets

## Guardrails

- Route every substantial task through the smallest useful director/lead/specialist set; do not load the whole studio when one team is enough.
- Keep engine-specific edits small, run the project/editor checks often, and inspect logs before broad rewrites.
- Do not overwrite existing art or resources unless the user explicitly asks for replacement.
- Keep generated assets inside the game project before referencing them from scenes, prefabs, blueprints, scripts, materials, or UI.
- Keep release package files portable: avoid user-specific paths, machine-specific versions, project-specific names, credentials, or local-only assumptions.
- Do not call a game slice complete until a player can understand the goal, perform the core action, see feedback, and complete or fail a short loop.
- Do not claim Unity or Unreal editor automation is available unless the environment check or active tools confirm it.
