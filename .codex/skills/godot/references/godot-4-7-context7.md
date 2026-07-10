# Godot 4.7 Context7 Rule

Use this reference for this scaffold before version-sensitive Godot work.

## Required Library

```text
/websites/godotengine_en_4_7
```

## Query When

- Editing `project.godot` settings.
- Using APIs introduced or changed after Godot 4.3.
- Changing import/export settings.
- Writing GDScript, C#, GDExtension, shader, physics, UI, or animation guidance.
- Reviewing advice that names only a generic Godot 4 target or an older minor version.

## Project Organization Findings

Godot 4.7 docs support organizing project files by domain or feature and using
`.gdignore` for documentation/source-only folders. This scaffold therefore uses:

- `game/` for entrypoints and autoloads.
- `features/` for gameplay/UI/level modules.
- `shared/` for reusable code.
- `assets/runtime/` for imported runtime assets.
- `assets/source/` for editable source assets with `.gdignore`.
- `docs/` and `tools/` with `.gdignore`.

## Import Metadata Rule

Commit source/runtime assets and generated `.import` sidecar files. Do not commit
the hidden `.godot/imported/` cache.
