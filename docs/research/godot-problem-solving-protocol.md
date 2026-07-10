# Godot 4.7 Problem-Solving Protocol

This template is meant to support real Godot game development work, not just a
toy demo. When agents or developers hit implementation problems, use this
protocol to decide where to look and how to validate the answer.

## Goal

Reach a project-specific, Godot 4.7-correct answer backed by:

- local project evidence,
- official Godot 4.7 documentation,
- and a runtime or export verification step when practical.

## Search Order

### 1. Inspect local project reality

Read the files that actually own the behavior:

- `project.godot`
- the relevant `.gd`, `.tscn`, `.tres`, `.gdshader`
- `docs/specs/project-context.md`
- `docs/specs/architecture.md`
- `docs/specs/dev-plan.md`
- `docs/specs/asset-list.md`
- `docs/specs/qa/test-plan.md`
- `docs/specs/qa/playtest-plan.md`

Do not jump to abstract advice before checking what the project already does.

### 2. Query official Godot 4.7 docs through Context7

Primary library:

```text
/websites/godotengine_en_4_7
```

Use Context7 proactively when the problem involves:

- GDScript or C# API correctness
- signals, Resources, autoloads, scene loading
- physics, collision, CharacterBody2D, TileMapLayer
- input, UI focus, keyboard/gamepad navigation
- rendering, CanvasItem shaders, import settings
- export presets, command-line behavior, debugger usage

Do not answer from memory when the issue is version-sensitive.

## Common Problem Categories

### Scene, node, or signal bugs

Check:

- scene ownership in `game/`, `features/`, and `shared/`
- current node paths and exported references
- `SignalBus`, `GameState`, `SceneLoader`, and `AppShell`

Verify by running:

```powershell
.\tools\godot\run-tests.ps1
.\tools\godot\headless-check.ps1
```

### UI, focus, and input bugs

Check:

- `shared/utils/input_bootstrap.gd`
- menu scenes under `features/ui/menu/`
- debug overlay and HUD behavior
- current `InputMap` actions

Official-doc focus:

- Control focus behavior
- keyboard/gamepad navigation
- `grab_focus()` timing
- focus neighbors and `focus_mode`

When needed, use the command-line debugger:

```powershell
C:\Godot\Godot_v4.7-stable_win64_console.exe -d --path .
```

### Asset import, export, and build issues

Check:

- `assets/source/` vs `assets/runtime/`
- `docs/specs/asset-list.md`
- `.import` sidecars
- `export_presets.cfg`
- `tools/godot/export-smoke.ps1`

Official-doc focus:

- command-line export
- renderer/export preset behavior
- import settings and asset compatibility

### Rendering, shader, and VFX issues

Check:

- `assets/runtime/shaders/`
- `features/vfx/shader_showcase/`
- renderer setting in `project.godot`

Official-doc focus:

- CanvasItem shader behavior
- renderer limits and compatibility
- screen-space shader constraints

### Architecture or scaling questions

Check:

- `docs/specs/architecture.md`
- `docs/specs/dev-plan.md`
- `.codex/skills/godot/references/`

Only add plugins or bigger frameworks after confirming vanilla Godot is not a
good fit. Use `docs/third_party/plugin-catalog.md` for shortlisted options.

## Validation Ladder

Prefer the strongest verifier the host can support:

1. `.\tools\godot\run-tests.ps1`
2. `.\tools\godot\headless-check.ps1`
3. `C:\Godot\Godot_v4.7-stable_win64_console.exe -d --path .`
4. `.\tools\godot\export-smoke.ps1`
5. manual route in `docs/specs/qa/playtest-plan.md`

## Answer Standard

A good answer inside this template should say:

1. What the local project currently does.
2. What the official Godot 4.7 docs say.
3. What change or next diagnostic step is recommended.
4. What command, scene, or export step was used to verify it.
5. What is still unknown, if anything.

## Current Boundaries

- This template is 2D-first.
- It is designed for small to medium single-player projects.
- 3D, multiplayer, and live-service work require an ADR first.
- The template provides a professional development path, not prebuilt content
  for every genre-specific system.
