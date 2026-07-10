# Development Plan

## Phase 0 - Scaffold Baseline

- Keep Godot 4.7 as the target version.
- Keep the template 2D-first unless a new architecture decision says otherwise.
- Keep Boot as the project entry and AppShell as the runtime routing owner.
- Keep `game/main/` as the runnable sample gameplay module loaded by AppShell.
- Preserve production directory structure.
- Confirm old `scenes/` and `scripts/` roots are not used for new runtime work.

## Phase 1 - Game Brief And First Playable

- Fill `game-brief.md`.
- Fill `docs/studio/brainstorm-log.md`, `grilling-gate.md`, and `project-charter.md`.
- Fill the core loop in `gdd.md`.
- Fill `docs/studio/gameplay-spec.md`, `balance-sheet.md`, `level-plan.md`, and `asset-production-plan.md`.
- Replace placeholder pickup-goal behavior with the real first playable mechanic.
- Keep `features/levels/level_001/` as the first vertical slice.
- Update `first-playable.md` acceptance criteria.

## Phase 2 - Core Systems

- Define reusable Resources for player, items, enemies, abilities, levels, and UI text.
- Add save/load only after the game has persistent state.
- Route scene transitions through `SceneLoader` and AppShell `ContentRoot`.
- Extend UI menus under `features/ui/menu/`, result screens under `features/ui/results/`, and debug tools under `features/ui/debug/`.
- Add tests for deterministic systems in `tests/unit/`.

## Phase 3 - Asset Pipeline

- Produce concept/reference assets under `assets/source/references/`.
- Store editable files under `assets/source/art/`, `audio/`, `blender/`, or `aseprite/`.
- Export runtime files to `assets/runtime/`.
- Use 2D sprite/UI/tile/audio defaults unless a project-specific ADR adds 2.5D/3D.
- Import through Godot and commit `.import` sidecars.
- Track every required asset in `asset-list.md`.

## Phase 4 - Level Production

- Create one folder per level under `features/levels/<level_id>/`.
- Keep level-specific spawn data, tilemaps, scripts, and resources together.
- Update the playtest route for every level.
- Add performance budgets for dense scenes.

## Phase 5 - Polish And QA

- Run `polish-checklist.md`.
- Run `qa/test-plan.md`.
- Run `tools/godot/run-tests.ps1`.
- Keep the AppShell-to-restart first-playable integration flow green.
- Run `qa/playtest-plan.md`.
- Fix clarity, feedback, input latency, camera issues, audio mix, UI readability, and accessibility blockers.

## Phase 6 - Export

- Keep committed presets for Windows Desktop, Linux, and Web in export_presets.cfg.
- Export release builds from Godot 4.7 with `tools/godot/export-smoke.ps1`.
- Smoke test locally available platform builds and use CI as the Linux/cross-platform export gate.
- Record unresolved export risks in `docs/production/sprint-status.yaml`.
