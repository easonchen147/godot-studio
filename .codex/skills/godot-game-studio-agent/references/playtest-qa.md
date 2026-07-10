# Playtest QA

Use this reference before calling a game slice complete.

## Smoke Test

- Project opens or runs from the configured Godot executable.
- Main scene launches.
- Console has no new parse errors, missing resources, or broken node paths.
- The first input action works.
- The player can reach success, failure, or restart state.

## First-Time-Player Test

Answer these in plain language:

- What does the player see first?
- What does the player think they should do?
- What input do they try first?
- What feedback confirms the input worked?
- What obstacle, choice, or tension appears?
- How does the loop reward, fail, or restart?

If any answer is unclear, improve UI, camera framing, tutorial prompt, level layout, or feedback before adding new features.

## Game-Effect Test

Check:

- Movement feels responsive.
- Hits, pickups, UI buttons, damage, death, and success are not silent.
- Important events are visible without reading logs.
- Camera is stable and frames the action.
- UI is readable and does not cover gameplay.
- Effects clarify action rather than obscure it.

## Regression Test

When changing gameplay:

- Re-run the core loop.
- Re-test the previous success state.
- Re-test the previous failure state.
- Inspect logs again.
- Update `docs/dev-plan.md` if scope or acceptance changed.

## Bug Report Format

```markdown
## Bug
- Symptom:
- Repro steps:
- Expected:
- Actual:
- Suspected cause:
- Fix:
- Verification:
```
