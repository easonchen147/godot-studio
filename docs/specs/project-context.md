# Project Context

## Target

This scaffold is a copy-ready Godot 4.7 2D production starter for AI-assisted game development. It should let an agent or developer begin a new 2D game by editing specs, replacing placeholder mechanics, adding assets, and running a verified first playable loop.

## Engine Version

- Required engine: Godot 4.7.
- Context7 source of truth: `/websites/godotengine_en_4_7`.
- Local executable used by this workspace: `C:\Godot\Godot_v4.7-stable_win64_console.exe`.
- Project setting: `config/features=PackedStringArray("4.7", "GL Compatibility")`.

Any future agent that finds Godot 4.8+ installed must first update this file, `AGENTS.md`, project-local skills, export settings, and validation notes before using the newer version.

## Current First Playable

The starter contains a minimal 2D loop:

1. Boot loads AppShell and shows the main menu.
2. Start Sample loads the sample gameplay scene into AppShell `ContentRoot`.
3. Player moves with WASD or arrow keys.
4. Player collects the yellow pickup.
5. Player reaches the green goal.
6. HUD and result screen confirm score and completion.

Runtime path:

- Entry scene: `project.godot -> game/boot/boot.tscn`
- App shell: `game/app/app_shell.tscn`
- Sample gameplay: `game/main/`
- First level: `features/levels/level_001/level_001.tscn`
- Player: `features/player/player.tscn`
- Pickup: `features/pickups/pickup.tscn`
- Goal: `features/goals/goal_zone.tscn`
- HUD: `features/ui/hud/hud.tscn`
- Menus/results/debug: `features/ui/menu/`, `features/ui/results/`, `features/ui/debug/`

## Development Principles

- Treat the template as 2D-first: use Node2D/Control/CharacterBody2D/Area2D,
  TileMapLayer, CanvasItem shaders, 2D audio, and 2D asset pipelines by default.
- Add 3D, 2.5D, multiplayer, or live-service systems only after an explicit
  architecture decision.
- Keep every new feature playable in a small vertical slice.
- Keep scenes, scripts, local Resources, and feature-specific assets together.
- Keep reusable code in `shared/` only after at least two features need it.
- Keep editable assets separate from runtime assets.
- Keep docs current enough that another agent can continue without rediscovery.

## Success Criteria

- `project.godot` opens in Godot 4.7.
- Boot and AppShell load without missing dependencies.
- The first playable loop can be completed.
- New work stays aligned with the documented 2D-first target.
- Runtime references use `res://game`, `res://features`, `res://shared`, or `res://assets`.
- No production code is added under old root-level `scenes/` or `scripts/`.

## Continuous Delivery Baseline

- The committed export presets are Windows Desktop, Linux, and Web.
- `tests/test_runner.gd` exercises the deterministic public first-playable flow from AppShell start through restart.
- GitHub Actions verifies the runner and headless load before exporting all three targets from official Godot 4.7 stable archives verified against their SHA512 manifest.
- Local Windows hosts may lack Linux templates; that is a local prerequisite, while CI is the cross-platform release gate.
