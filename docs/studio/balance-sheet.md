# Balance Sheet

All values are hypotheses until playtested.

| Variable | Base | Min | Max | Rationale | Tuning Signal | Owner |
| --- | --- | --- | --- | --- | --- | --- |
| player_move_speed | 240 px/s | 160 | 360 | Existing sample feels readable at desktop scale. | Player overshoots or feels sluggish. | `features/player/` |
| pickup_score | 1 | 1 | 5 | Minimal first-playable reward. | HUD/reward clarity. | `features/pickups/` |
| first_level_target_time | 60 s | 30 | 120 | First playable should prove the loop fast. | New players finish too fast/slow. | `features/levels/level_001/` |

## Economy/Progression Notes

TBD.

## Playtest Questions

- Did the player know what to do without help?
- Did any value feel unfair before the player understood the rule?
- Which value should be changed first?

## Tuning Pass Rule

For a focused balance iteration, use `docs/studio/tuning-pass.md`. Change a
small set of related values, record before/after evidence, then add a
`docs/specs/change-log.md` entry when the pass changes the current design.
