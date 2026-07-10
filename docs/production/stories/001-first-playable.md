# Story 001 - Replace Placeholder First Playable

## Goal

Replace the starter pickup-goal loop with the actual one-minute first playable for the game.

## Acceptance Criteria

- The main scene loads in Godot 4.7.
- Boot reaches AppShell, and AppShell can start the sample gameplay module.
- The player can understand the goal without reading external instructions.
- The player can perform the primary action.
- The loop has success feedback.
- Failure or retry behavior is defined if relevant.
- HUD, sound, animation, and VFX placeholders are tracked in `docs/specs/asset-list.md`.
- `docs/specs/qa/playtest-plan.md` includes the exact route.

## Implementation Notes

- Keep the first playable under `features/levels/level_001/`.
- Create new feature folders rather than adding unrelated logic to AppShell or the sample gameplay composition.
- Keep reusable code out of `shared/` until at least two features need it.
