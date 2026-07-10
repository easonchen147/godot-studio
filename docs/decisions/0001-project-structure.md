# 0001 - Production-Oriented Godot Project Structure

## Status

Accepted.

## Context

The scaffold needs to support AI-assisted production, not only a small demo. A flat split like `scenes/` and `scripts/` becomes hard to maintain when gameplay, UI, levels, assets, and data grow independently.

Godot 4.7 documentation supports organizing scenes and related assets by project domain or feature, and using `.gdignore` to keep documentation/source-only folders out of Godot's import process.

## Decision

Use a production structure:

- `game/` for entrypoints and global runtime services.
- `features/` for player-facing modules, with scenes/scripts/data kept together.
- `shared/` for genuinely reusable code and Resource schemas.
- `assets/runtime/` for engine-ready assets.
- `assets/source/` for editable sources excluded by `.gdignore`.
- `docs/` for specs and decisions excluded by `.gdignore`.
- `tools/` for external scripts excluded by `.gdignore`.

## Consequences

- New agents know where to place files without rediscovering conventions.
- Features can be moved, copied, or deleted with less cross-folder churn.
- Runtime assets and source assets stay separate.
- The first playable remains a small vertical slice under `features/levels/level_001/`.
- Any future deviation must be documented as a new decision.
