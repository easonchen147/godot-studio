# Asset Pipeline

This starter uses a two-stage asset pipeline:

1. `assets/source/` keeps editable source files: concepts, Aseprite files,
   layered art, audio sessions, reference boards, and optional Blender sources.
   It contains `.gdignore` so Godot does not import those working files.
2. `assets/runtime/` keeps engine-ready files referenced by scenes, scripts,
   resources, and shaders.

Use these runtime folders by default:

- `assets/runtime/sprites/` for sprites, atlases, and animation frames.
- `assets/runtime/tilesets/` for 2D tilesheets and TileSet inputs.
- `assets/runtime/textures/` for shared 2D textures, masks, and material inputs.
- `assets/runtime/ui/` for icons, panels, button states, cursors, and HUD art.
- `assets/runtime/vfx/` for flipbooks, particles, and effect sprites.
- `assets/runtime/shaders/` for `.gdshader` files.
- `assets/runtime/audio/music/`, `sfx/`, and `ambience/` for runtime audio.
- `assets/runtime/fonts/` for licensed TTF/OTF files.
- `assets/runtime/models/` only after an ADR approves optional 2.5D/3D work.

Record every non-placeholder runtime asset in `docs/specs/asset-list.md`,
including source, license, owner feature, import settings, and verification
notes. Commit Godot `.import` sidecar files generated next to runtime assets,
but do not commit `.godot/imported/`.

`assets/import_presets/` is reserved for import recipes, naming conventions,
and tool notes. Keep the base template small; do not add large source assets or
third-party packs unless a derived game explicitly needs them.
