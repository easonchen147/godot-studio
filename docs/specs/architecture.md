# Architecture

## Runtime Shape

```text
project.godot
  game/boot/boot.tscn
    Boot
      SceneLoader.change_root_scene(game/app/app_shell.tscn)

game/app/app_shell.tscn
  AppShell
    ContentRoot
      game/main sample gameplay scene
    MainMenu
    OptionsMenu
    CreditsScreen
    PauseMenu
    ResultScreen
    DebugOverlay
    TransitionLayer
```

`game/boot/` is the canonical entry surface. `game/app/` owns menu, options, pause, result, debug, and gameplay routing. `game/main/` is intentionally thin sample gameplay composition: it starts the run and composes the active 2D level plus HUD. Gameplay rules for the starter loop live in `features/levels/level_001/level_001.gd` because the level owns this specific pickup-goal sequence.

## 2D-First Boundary

This architecture targets 2D Godot games. Default feature work should use:

- `Node2D`, `CharacterBody2D`, `Area2D`, `CollisionShape2D`, `Camera2D`.
- `Control` and `CanvasLayer` for UI and overlays.
- `TileMapLayer` and `TileSet` for tile-based levels.
- CanvasItem shaders for sprite/UI/VFX work.
- 2D audio routing through the existing audio buses.

Do not introduce 3D scene trees, 3D physics, 3D camera systems, or runtime model
pipelines without a new ADR that explains why the starter is no longer 2D-first.

## Directory Ownership

| Folder | Ownership |
| --- | --- |
| `game/boot/` | Project entry and boot/loading hooks. |
| `game/app/` | AppShell runtime routing, support screens, and gameplay content host. |
| `game/main/` | Sample gameplay composition loaded by AppShell. |
| `game/autoload/` | Global services only. |
| `features/<feature>/` | Feature scene, script, local data, and local assets. |
| `shared/components/` | Reusable gameplay components. |
| `shared/resources/` | Base Resource classes and shared data schemas. |
| `shared/states/` | Shared state-machine base classes. |
| `shared/utils/` | Stateless helpers and setup utilities. |
| `assets/runtime/` | Engine-ready assets referenced by scenes. |
| `assets/source/` | Editable source files excluded from Godot import by `.gdignore`. |
| `docs/` | Specs, decisions, plans, QA docs, and production tracking. |
| `docs/studio/` | Fixed output docs for concept, gameplay, balance, level, asset, and ticket planning. |
| `tests/` | Project-local Godot smoke and future automated checks. |
| `tools/` | Import, build, export, and CI helpers excluded from Godot import. |

## Autoloads

| Autoload | Responsibility | Forbidden |
| --- | --- | --- |
| `SignalBus` | Global events that cross feature boundaries. | Scene-specific node references. |
| `SettingsManager` | `ConfigFile` settings, window state, and debug/display toggles. | Feature rules or save-game content. |
| `GameState` | Current score, run state, session state, and active gameplay scene path. | Inventory, AI, level ownership, or content catalogs. |
| `AudioManager` | Central audio bus helpers and future playback routing. | Feature-specific sound decisions. |
| `SceneLoader` | Root scene changes and AppShell content replacement. | Game rules or save state. |

Add an autoload only when the service must exist across scene transitions.

## Feature Module Pattern

```text
features/my_feature/
  my_feature.tscn
  my_feature.gd
  my_feature_data.tres
  my_feature_data.gd
  assets/
```

Use feature-local folders first. Move code to `shared/` only when reuse is real.

## Data Pattern

- Use custom `Resource` classes for item data, level data, player tuning, ability data, dialogue, enemy definitions, and spawn tables.
- Use `.tres` for hand-authored data and `.res` only when binary storage is intentionally chosen.
- Duplicate shared Resources before mutating per-instance state.

## Signal Pattern

- Parent-child communication can use direct typed node references.
- Peer or cross-feature communication should use signals.
- Global events go through `SignalBus`.
- Connect signals once in `_ready()` or setup methods, never in `_process()`.

## Asset Reference Pattern

- Feature scenes can reference assets in `assets/runtime/`.
- Editable source files stay in `assets/source/`.
- Update `docs/specs/asset-list.md` whenever a referenced asset changes.
- Commit `.import` sidecar files generated next to runtime assets.
- Do not commit `.godot/imported/`.

## Scaling Path

For a larger game, add these modules without changing the root contract:

- `features/enemies/<enemy_name>/`
- `features/combat/`
- `features/inventory/`
- `features/dialogue/`
- `features/quests/`
- `features/levels/<level_id>/`
- `features/ui/menu/`
- `features/ui/results/`
- `features/ui/debug/`
- `features/ui/settings/`
- `shared/save/`
- `shared/localization/`

For 3D expansion, create a separate architecture decision first. Do not silently
mix 3D conventions into this 2D starter.
