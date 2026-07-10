# Asset List And Pipeline

Use this file as the source of truth for every asset the game needs or already references.

This starter is 2D-first. Treat 3D models and Blender sources as optional
future extensions, not part of the default production path.

## Pipeline Rules

1. Editable sources go in `assets/source/`.
2. Engine-ready files go in `assets/runtime/`.
3. Godot-generated `.import` sidecars next to runtime assets should be committed.
4. `.godot/imported/` should not be committed.
5. Every scene reference must use stable `res://assets/runtime/...` paths.
6. Large generated batches must be named, filtered, and documented before import.

## Runtime Folder Map

| Asset Type | Runtime Folder | Source Folder |
| --- | --- | --- |
| Sprites | `assets/runtime/sprites/` | `assets/source/art/` or `assets/source/aseprite/` |
| Animation frames | `assets/runtime/sprites/<actor>/animations/` | `assets/source/aseprite/` |
| Tilesets | `assets/runtime/tilesets/` | `assets/source/art/` |
| Optional 2.5D/3D models | `assets/runtime/models/` | `assets/source/blender/` |
| Textures/material inputs | `assets/runtime/textures/` | `assets/source/art/` |
| UI art/icons | `assets/runtime/ui/` | `assets/source/art/` |
| VFX sprites/shaders | `assets/runtime/vfx/`, `assets/runtime/shaders/` | `assets/source/art/` |
| Music | `assets/runtime/audio/music/` | `assets/source/audio/` |
| SFX | `assets/runtime/audio/sfx/` | `assets/source/audio/` |
| Ambience | `assets/runtime/audio/ambience/` | `assets/source/audio/` |
| Fonts | `assets/runtime/fonts/` | `assets/source/art/` or licensed package |

## 2D Import Guidance

- Sprites and UI: use PNG or WebP; keep pixel art lossless and avoid VRAM
  compression for low-resolution pixel art.
- Animation: prefer atlases or spritesheets over one file per frame when
  practical; record frame count and FPS.
- Tiles: use tilesheets with `TileMapLayer`; define collision, navigation, and
  occlusion layers only when needed.
- Audio: use WAV for short repeated SFX; use OGG for music, ambience, and longer
  loops; prefer mono for simple one-shot SFX.
- Shaders: use `shader_type canvas_item` for 2D sprites, UI, and screen effects.
- Commit `.import` sidecars next to runtime assets after Godot import.

## Asset Register

| ID | Type | Owner Feature | Runtime Path | Source Path | Status | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| placeholder_player_shape | 2D visual | `features/player/` | scene polygon | none | placeholder | Replace with sprite or rig. |
| placeholder_pickup_shape | 2D visual | `features/pickups/` | scene polygon | none | placeholder | Replace with collectible sprite/VFX. |
| placeholder_goal_shape | 2D visual | `features/goals/` | scene polygon | none | placeholder | Replace with portal/goal art. |
| placeholder_hud_text | UI | `features/ui/hud/` | scene labels | none | placeholder | Replace with styled UI theme/font. |
| studio_ui_theme | UI theme | `features/ui/` | `shared/resources/studio_ui_theme.tres` | none | implemented | Shared menu/HUD/debug starter styling. |
| app_shell_screens | UI | `game/app/`, `features/ui/` | menu/result/debug scenes | none | implemented | Main menu, options, credits, pause, result, debug overlay. |
| audio_bus_layout | audio routing | `AudioManager` | `audio_bus_layout.tres` | none | implemented | Master, Music, SFX, UI, Ambience buses. |
| gdquest_shader_subset | shader library | `features/vfx/shader_showcase/` | `assets/runtime/shaders/gdquest/` | upstream MIT shader source | implemented | Curated GDQuest shader source only; no CC-BY-NC-SA art/model assets imported. |
| shader_showcase | VFX demo UI | `features/vfx/shader_showcase/` | generated preview textures at runtime | none | implemented | Main-menu showcase for bundled shader subset. |

## Third-Party Shader Libraries

| Library | Runtime Path | Notice | License Boundary |
| --- | --- | --- | --- |
| GDQuest Godot Shaders | `assets/runtime/shaders/gdquest/` | `docs/third_party/gdquest-godot-shaders.md` | MIT shader source imported; upstream CC-BY-NC-SA art assets excluded. |

## UI Asset Template

- Surface:
- Required icons:
- Required panels:
- Required font:
- States: normal, hover, pressed, disabled, focused
- Accessibility notes:
- Runtime paths:
- Source paths:

## Sound Asset Template

- Event:
- Category: music / sfx / ambience / voice
- Length:
- Looping:
- Bus:
- Loudness target:
- Runtime path:
- Source path:

## Current Runtime Audio Buses

- `Master`: whole-project output.
- `Music`: music and long-form score.
- `SFX`: gameplay feedback and one-shots.
- `UI`: menu/navigation sounds.
- `Ambience`: looping environment beds.

## Animation Asset Template

- Actor:
- Animation:
- Frame count:
- FPS:
- Looping:
- Hitbox/active frame notes:
- Runtime path:
- Source path:

## 3D Model Asset Template

- Object:
- Scale:
- Poly budget:
- Materials:
- Collision shape:
- LOD needs:
- Runtime path:
- Source `.blend` path:

## Level Asset Template

- Level ID:
- Tilemaps/models:
- Props:
- Lighting/environment:
- Spawn tables:
- Music/ambience:
- Performance risk:
