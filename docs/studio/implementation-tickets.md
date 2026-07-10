# Implementation Tickets

Use this file to split a prototype into small buildable work.

## Ticket Template

### Ticket: TBD

- Goal: TBD.
- Owner role: TBD.
- Likely files:
  - TBD.
- Acceptance criteria:
  - TBD.
- Automated verification:
  - `tools/godot/run-tests.ps1`
- Manual playtest:
  - TBD.
- Rollback risk:
  - TBD.

## Initial Tickets

### Ticket: Replace Placeholder Loop

- Goal: Replace pickup-goal sample with the real first-playable mechanic.
- Owner role: Game Designer + Godot Gameplay Scripter.
- Likely files:
  - `features/levels/level_001/`
  - `features/player/`
  - `features/ui/hud/`
  - `docs/specs/qa/playtest-plan.md`
- Acceptance criteria:
  - Player can complete or fail a 60-second loop.
  - HUD communicates only relevant state.
  - Feedback exists for action, reward, fail, and success.
- Automated verification:
  - `tools/godot/run-tests.ps1`
- Manual playtest:
  - Follow `docs/specs/qa/playtest-plan.md`.
- Rollback risk:
  - Keep the old sample loop recoverable until the new loop passes QA.
