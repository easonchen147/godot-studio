# Import Presets

Store project-specific import recipes here when a derived game starts adding
real assets.

Recommended baseline:

- Pixel art: lossless import, nearest filtering, no VRAM compression unless
  measured and accepted.
- Painted sprites and UI: PNG or WebP, stable lowercase snake_case names.
- Animation: prefer atlases or spritesheets over many loose frame files.
- Tilesets: use tilesheets with `TileMapLayer`; define collision/navigation data
  in Godot where practical.
- Short SFX: WAV for frequently repeated clips.
- Music, ambience, and long loops: OGG.
- Fonts: TTF/OTF with license recorded in `docs/specs/asset-list.md`.
- 2D shaders: `.gdshader` using `shader_type canvas_item`.

Every import recipe should include: source format, runtime target folder,
Godot import settings, naming convention, compression/filtering decision, and
how to verify the asset in-game.
