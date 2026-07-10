# Asset Pipeline

Use this reference for ImageGen, placeholder assets, imported art, UI mockups, icons, textures, and final asset replacement across Godot, Unity, and Unreal.

## Folder Policy

- `art/concepts/`: concept images and mood references.
- `art/source/`: editable or source art.
- `assets/`: portable runtime source assets for Godot or shared asset staging.
- `Assets/`: Unity runtime assets when working inside a Unity project.
- `Content/`: Unreal runtime content when working inside an Unreal project.
- `assets/sprites/`, `assets/textures/`, `assets/ui/`, `assets/vfx/`: recommended Godot/shared subfolders.
- `audio/sfx/`: sound effects.
- `audio/music/`: music loops and stingers.

## Naming

Use stable, descriptive names:

- `player_idle.png`
- `enemy_slime_walk.png`
- `ui_health_icon.png`
- `vfx_hit_spark.png`
- `sfx_pickup_coin.wav`

Avoid generated random names in scenes. Rename assets before binding them to resources.

## ImageGen Workflow

1. Define art direction from `docs/game-brief.md`.
2. Generate a small style target first: player, enemy, pickup, UI icon.
3. Save concepts under `art/concepts/`.
4. Save runtime-ready images under the selected engine's project asset folder.
5. Import through the selected engine or run an editor import check.
6. Bind assets to scenes/resources, Unity prefabs/materials, or Unreal assets/materials as appropriate.
7. Update `docs/asset-list.md` with status and usage.

## Placeholder Policy

Placeholders are acceptable only if they preserve gameplay readability:

- Use distinct shapes and colors for player, enemy, hazard, pickup, exit.
- Label debug placeholders only when it helps the developer; avoid shipping labels inside the game world.
- Replace placeholders that affect player understanding before calling a slice polished.

## UI Mockups

For menus and HUD:

- Sketch the hierarchy before generating art.
- Use icons for repeated resources.
- Keep button states: default, hover, pressed, disabled.
- Verify text at 1280x720 and a smaller fallback resolution.

## Import Checks

After adding image assets:

- Run the relevant editor import once when available.
- Treat engine-generated import metadata as derived artifacts, not source truth.
- Fix missing resource paths before continuing.
