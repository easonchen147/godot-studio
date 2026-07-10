# Level Plan

## Level ID

`level_001`

## Intent

- Player fantasy: TBD.
- Teaching beat: TBD.
- Reward beat: TBD.
- Failure/retry beat: TBD.
- Estimated playtime: 60 seconds.

## 2D Layout

| Area | Purpose | Notes |
| --- | --- | --- |
| Spawn | Introduce control | Player can move safely. |
| First interaction | Teach core verb | Use readable shape/color/audio. |
| Choice or obstacle | Create decision | Keep path legible. |
| Goal | Resolve loop | Must be visible or clearly foreshadowed. |

## Flow

```text
Spawn -> Teach Verb -> Reward/Obstacle -> Goal -> Result
```

## Blockout Checklist

- [ ] Critical path visible within 3 seconds.
- [ ] First reward is reachable quickly.
- [ ] No dead end looks like the exit.
- [ ] Camera frames the player and next useful target.
- [ ] Placeholder shapes are readable without final art.
- [ ] Any hazard is telegraphed before it can punish the player.

## Godot Implementation Notes

- Prefer `TileMapLayer` for tile layouts.
- Use scene tiles only for interactive objects.
- Keep level-specific rules in `features/levels/level_001/`.
- Move reusable behavior to `shared/` only after a second level needs it.

## Production Pass

When the first level moves beyond this summary, copy the working details into
`docs/studio/level-slice.md` or a component spec such as
`docs/specs/components/level_001.md`. Keep this file as the readable overview.
