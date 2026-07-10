# Gameplay Spec

## Core Loop

### Moment-To-Moment Loop

1. Player does: TBD.
2. Game responds: TBD.
3. Player receives: TBD.
4. Next decision: TBD.

### Session Loop

1. Start condition: TBD.
2. Escalation: TBD.
3. Win/fail condition: TBD.
4. Restart or reward: TBD.

## Controls

| Verb | Keyboard | Gamepad | Touch | Notes |
| --- | --- | --- | --- | --- |
| Move | WASD / Arrow Keys | Left Stick | TBD | Existing scaffold supports keyboard. |
| Interact | E | TBD | TBD | TBD |
| Pause | Escape / P | Start | TBD | Existing scaffold supports pause. |
| Restart | R | TBD | TBD | Existing scaffold supports restart. |

## Mechanics

### Mechanic: TBD

- Purpose: TBD.
- Player fantasy: TBD.
- Input: TBD.
- Output/state change: TBD.
- Success condition: TBD.
- Failure state: TBD.
- Edge cases: TBD.
- Tuning levers: TBD.
- Implementation owner: TBD.

## Feedback Contract

| Event | Visual | Audio | UI | VFX/Shader |
| --- | --- | --- | --- | --- |
| Player action | TBD | TBD | TBD | TBD |
| Pickup/reward | TBD | TBD | TBD | TBD |
| Hazard/fail | TBD | TBD | TBD | TBD |
| Goal/success | TBD | TBD | TBD | TBD |

## Technical Notes

- Use typed GDScript.
- Prefer feature-local scenes and Resources.
- Use signals for cross-feature communication.
- Keep first-playable logic in the first level until reuse is real.
