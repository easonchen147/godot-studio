---
name: godot-studio-project
description: Project-local Godot Studio starter workflow. Use when working inside this portable Godot 4.7 scaffold to place files in the production directory layout, update specs, preserve the first playable loop, run Godot validation, or guide AI agents through this project's game development process.
---

# Godot Studio Project

Use this skill as the project-specific entrypoint before editing this scaffold.

## Required Reads

1. `AGENTS.md`
2. `docs/specs/project-context.md`
3. `docs/specs/architecture.md`
4. `docs/specs/spec-index.md`
5. The relevant feature scene/script/spec/component files for the task.

## Version Rule

Target Godot 4.7. For API uncertainty, query Context7 library `/websites/godotengine_en_4_7` before implementation.

## Dimension Rule

This scaffold is 2D-first. Default to Node2D, Control, CharacterBody2D, Area2D,
TileMapLayer, Camera2D, CanvasItem shaders, and 2D asset/audio/UI pipelines.
Do not add 3D systems unless an ADR explicitly changes the project target.

## Placement Rule

- Engine entrypoints and autoloads: `game/`
- Product modules: `features/<feature>/`
- Shared reusable code: `shared/`
- Runtime assets: `assets/runtime/`
- Editable source assets: `assets/source/`
- Specs and decisions: `docs/`
- Prototype/game soul docs: `docs/studio/`
- Tests and checks: `tests/`
- Pipeline scripts: `tools/`

Do not add new root-level `scenes/` or `scripts/` folders.

## Workflow

1. Confirm the requested change against `docs/specs/game-brief.md` and `docs/specs/dev-plan.md`.
2. For new game work, use `.codex/skills/godot-2d-game-studio/SKILL.md` and
   update `docs/studio/` Layer 1 game-soul docs before implementation.
3. Read `docs/specs/spec-index.md` and decide whether the change belongs in a
   core spec or a short component spec copied from
   `docs/specs/components/TEMPLATE.md`.
4. Keep Boot/AppShell loading and the smallest playable loop working.
5. Add or update feature-local scenes, scripts, Resources, and assets together.
6. Update `docs/specs/asset-list.md` when adding UI, sound, animation frames, sprites, textures, VFX, shaders, or level content.
7. For production passes, use the smallest useful Layer 2 sheet:
   `docs/studio/system-sheet.md`, `level-slice.md`, `tuning-pass.md`,
   `playtest-report.md`, or `content-audit.md`.
8. Update QA docs when adding behavior a player can test.
9. Update `docs/specs/change-log.md` for meaningful design, runtime, asset,
   QA, dependency, or release changes.
10. If a derived project replaces the local spec workflow, record the new source
   of truth and mappings in an ADR before implementation continues.
11. Run Godot 4.7 headless when available. Prefer
   `tools\godot\headless-check.ps1`, which wraps
   `--headless --path <project> --quit` with isolated project-local user data.
12. Search for stale paths and stale versions before finishing.

## Problem-Solving Protocol

When the task is debugging, troubleshooting, or giving implementation advice:

1. Read the relevant local code, scene, resource, and spec files first.
2. If engine behavior, API correctness, UI focus, import/export, rendering,
   input, or project settings are involved, query Context7 library
   `/websites/godotengine_en_4_7` before concluding.
3. Use `.codex/skills/godot/references/godot-4-7-context7.md` and the relevant
   module references when the issue touches architecture or subsystem behavior.
4. Reproduce with the strongest available verifier:
   - `tools\godot\run-tests.ps1`
   - `tools\godot\headless-check.ps1`
   - `C:\Godot\Godot_v4.7-stable_win64_console.exe -d --path .`
   - `tools\godot\export-smoke.ps1`
5. Escalate to `docs/third_party/plugin-catalog.md` only when vanilla Godot is
   clearly insufficient for the requested feature or workflow.

Do not give generic Godot advice when the project needs a Godot 4.7 answer.
