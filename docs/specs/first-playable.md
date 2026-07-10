# First Playable Definition

The first playable is the smallest complete version that proves the game can be understood and played.

## Current Starter Loop

- Move with WASD or arrow keys.
- Collect the yellow pickup.
- Reach the green goal.
- See score and completion feedback in HUD.

## Replacement Criteria

When replacing the placeholder loop, the new first playable must include:

- Clear spawn point.
- Clear objective.
- One primary action.
- One obstacle, cost, or risk.
- One success condition.
- One failure or retry condition when applicable.
- HUD or world feedback.
- Sound feedback for primary action and success/failure when audio exists.
- A manual playtest route in `qa/playtest-plan.md`.

## Acceptance Checklist

- [ ] Boot reaches AppShell and AppShell loads the sample gameplay module.
- [ ] Player can perform the core action.
- [ ] Player can complete the objective.
- [ ] Player receives immediate feedback.
- [ ] The loop can be repeated after restart.
- [ ] The automated runner covers AppShell start, pickup, HUD update, goal, result, and restart through public signals.
- [ ] No missing resources appear in the editor output.
- [ ] No legacy scene/script resource-root references remain.
- [ ] Specs and asset list are updated.
