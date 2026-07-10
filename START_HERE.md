# Godot Studio Starter

Portable Godot 4.7 2D game starter for AI-assisted production.

Full Chinese workflow guide: `README.md`.

This template is intentionally 2D-first. Build new games from `Node2D`,
`Control`, `CharacterBody2D`, `Area2D`, `TileMapLayer`, CanvasItem shaders, and
2D asset/audio/UI workflows unless a new architecture decision changes the
target.

## Fast Start

1. Open this directory in Godot 4.7.
2. Press Play from `project.godot`; the project starts at Boot, then loads AppShell.
3. Choose Start Sample from the main menu.
4. Move the player with WASD or arrow keys.
5. Collect the yellow pickup, then reach the green goal.
6. Open Shader Showcase from the main menu to preview the bundled GDQuest shader subset.
7. Use Esc/P for pause, R for restart, and F3 for the debug overlay.
8. Open the folder in Codex and let agents read `AGENTS.md`.

## Verification Commands

Run from this directory:

```powershell
.\tools\godot\run-tests.ps1
.\tools\godot\headless-check.ps1
.\tools\godot\export-smoke.ps1 -Preset "Windows Desktop"
.\tools\godot\export-smoke.ps1 -Preset "Linux"
.\tools\godot\export-smoke.ps1 -Preset "Web"
```

If PowerShell blocks local `.ps1` files, run the same command with a process-only
policy override, for example:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\godot\run-tests.ps1
```

The export smoke requires matching Godot `4.7.stable` templates for the selected Windows Desktop, Linux, or Web preset.
If templates are cached outside `%APPDATA%\Godot\export_templates`, pass:

```powershell
.\tools\godot\export-smoke.ps1 -Preset "Windows Desktop" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
.\tools\godot\export-smoke.ps1 -Preset "Linux" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
.\tools\godot\export-smoke.ps1 -Preset "Web" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
```

## What Is Included

- Minimal runnable Godot 4.7 project.
- Production-oriented folder layout: `game/`, `features/`, `shared/`, `assets/`, `docs/`, `tests/`, `tools/`.
- Project-local Codex skills under `.codex/skills/`.
- Project-specific skill at `.codex/skills/godot-studio-project/SKILL.md`.
- 2D studio workflow skill at `.codex/skills/godot-2d-game-studio/SKILL.md`.
- Fixed prototype planning documents and production-pass sheets under `docs/studio/`.
- Specs under `docs/specs/`.
- Starter autoloads: `SignalBus`, `SettingsManager`, `GameState`, `AudioManager`, `SceneLoader`.
- Runtime shell: Boot, AppShell, main menu, options, credits, pause, result, and debug overlay.
- GDQuest shader subset under `assets/runtime/shaders/gdquest/`, with a main-menu Shader Showcase.
- Starter gameplay modules: `Player`, `Pickup`, `GoalZone`, `Level001`, `HUD`.
- Godot CLI wrappers for scaffold tests and Windows/Linux/Web export smoke.
- Optional plugin shortlist at `docs/third_party/plugin-catalog.md`; no large
  editor plugin is installed by default.
- MIT license and open-source audit notes.
- `audio_bus_layout.tres` with `Master`, `Music`, `SFX`, `UI`, and `Ambience`.
- Shared UI theme at `shared/resources/studio_ui_theme.tres`.
- Asset pipeline folders for UI, sprites, animation frames, audio, VFX, shaders, models, source files, and import presets.
- Layer 2 studio sheets for system design, level slices, tuning passes, playtest reports, and content audits.

## First Project Tasks

Update these files before expanding scope:

1. `docs/specs/game-brief.md`
2. `docs/specs/project-context.md`
3. `docs/specs/gdd.md`
4. `docs/specs/dev-plan.md`
5. `docs/specs/asset-list.md`
6. `docs/specs/architecture.md`
7. `docs/studio/project-charter.md`
8. `docs/studio/gameplay-spec.md`
9. `docs/studio/level-plan.md`
10. `docs/studio/asset-production-plan.md`

Before the first real production pass, decide whether these lightweight sheets
are needed:

1. `docs/studio/system-sheet.md`
2. `docs/studio/level-slice.md`
3. `docs/studio/tuning-pass.md`
4. `docs/studio/playtest-report.md`
5. `docs/studio/content-audit.md`

Skip a sheet when it does not reduce ambiguity. Fill it when it prevents
confusion across design, code, assets, QA, or release work.

Then replace the placeholder pickup loop with the real first playable mechanic while keeping `features/levels/level_001/` runnable.

## CI Delivery

GitHub Actions runs the deterministic first-playable test and headless load before exporting Windows Desktop, Linux, and Web. It is the authoritative Linux and cross-platform verification path; artifact creation is not a substitute for browser or player-device QA.
