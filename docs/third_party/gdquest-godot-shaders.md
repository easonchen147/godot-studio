# GDQuest Godot Shaders Integration

## Source

- Repository: https://github.com/gdquest-demos/godot-shaders
- Upstream project name: Godot Shaders
- Integrated commit: `05a3931acc85513b67b80b6e88671a596a3f9693`
- Integrated into: `assets/runtime/shaders/gdquest/`

## What Was Imported

This starter imports a curated runtime subset of MIT-licensed `.gdshader` files:

- 2D outlines: inner, outer, inner/outer
- 2D dissolve and dissolve mask
- baked sprite glow and glow prepass
- Gaussian blur variants
- invert, pointilism, shockwave
- noise generators: random, value, layered value, Voronoi, Perlin
- palette swap, 2D clouds, 2D water

The original GDQuest repository is a shader/demo library, not a standard Godot
plugin with `plugin.cfg`. It also contains demo scenes and art assets. Those were
not imported into this template.

## License Boundary

The upstream repository states:

- demo source code, scene files, shader files, and Godot-generated resources are
  MIT licensed
- art assets, image textures, and 3D models are CC-BY-NC-SA 4.0

This template imports only shader source files so the starter remains suitable
for commercial project bootstrapping. The MIT notice is included at
`assets/runtime/shaders/gdquest/THIRD_PARTY_NOTICE.md`.

## Local Compatibility Notes

- The upstream repository README says the project is still being ported to
  Godot 4.
- `canvas_pointilism.gdshader` has one local Godot 4.7 compatibility edit:
  an unused `PI` constant was removed because Godot 4.7 already defines `PI`.
- File names were normalized to this starter's shader naming convention.

## Usage

Open `features/vfx/shader_showcase/shader_showcase.tscn` or launch the project
and choose `Shader Showcase` from the main menu. The showcase creates procedural
preview textures at runtime, so it does not depend on upstream non-commercial
art assets.

For project-specific VFX, copy a shader from `assets/runtime/shaders/gdquest/`
into a feature-local folder, tune its uniforms, and document the resulting asset
in `docs/specs/asset-list.md`.
