# Level Slice

Use this template for one playable level, arena, room chain, encounter slice, or
tutorial route. It is the production-level companion to `level-plan.md`.

## Slice ID

- Level: `level_001`
- Scene path: `features/levels/level_001/level_001.tscn`
- Owner role: Level Designer.
- Status: concept / blockout / playable / tuned / locked.

## Goal

- Player objective: TBD.
- Skill taught or tested: TBD.
- Target duration: TBD.
- Failure or retry rule: TBD.

## Beat Map

| Beat | Space | Player Action | Teaching/Pressure | Feedback |
| --- | --- | --- | --- | --- |
| Spawn | TBD | Learn controls | Safe read | TBD |
| First verb | TBD | Use core action | Low pressure | TBD |
| Decision | TBD | Choose path/timing | Medium pressure | TBD |
| Goal | TBD | Resolve loop | Reward | TBD |

## Layout Notes

- Base resolution / camera framing: TBD.
- Tile size or world grid: TBD.
- Critical path visibility: TBD.
- Optional branch: TBD.
- Hazard/reward spacing: TBD.
- Restart distance: TBD.

## Encounter And Content Table

| Element | Count | Runtime Path | Purpose | Risk |
| --- | --- | --- | --- | --- |
| Player spawn | 1 | TBD | Start route | TBD |
| Pickup / reward | TBD | TBD | Teach reward | TBD |
| Goal / exit | 1 | TBD | Resolve route | TBD |

## Asset And Audio Needs

| Need | Placeholder OK? | Runtime Path | Source/License |
| --- | --- | --- | --- |
| Background/readability art | Yes | `assets/runtime/` | TBD |
| SFX cue | Yes | `assets/runtime/audio/sfx/` | TBD |
| VFX cue | Yes | `assets/runtime/vfx/` or shader | TBD |

## Metrics

| Metric | Target | Observed | Action |
| --- | --- | --- | --- |
| First objective understood | >= 80% of testers | TBD | TBD |
| First completion time | TBD | TBD | TBD |
| Failure before learning | Low | TBD | TBD |

## Playtest Route

1. Start from the main menu.
2. Enter this level.
3. Complete the critical path without developer hints.
4. Trigger one failure/retry if the level has failure.
5. Record confusion, readability, camera, input, audio, and reward feedback.

## Exit Criteria

- [ ] Critical path is readable with placeholder art.
- [ ] Player receives feedback for progress, failure, and completion.
- [ ] Level-specific rules stay inside `features/levels/<level_id>/`.
- [ ] Reusable behavior is moved to `shared/` only after real reuse appears.
- [ ] `docs/specs/qa/playtest-plan.md` includes this route.

