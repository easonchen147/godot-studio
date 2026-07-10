# System Sheet

Use this template when a mechanic, UI flow, economy, enemy behavior, save rule,
or feedback loop needs more detail than `gameplay-spec.md`.

Keep one sheet per system. Prefer a short sheet over spreading system rules
across chat history, tickets, and code comments.

## System ID

- Name: TBD.
- Owner role: Game Designer / Systems Designer / Technical Director.
- Runtime owner: `features/<feature>/` or `shared/<system>/`.
- Related specs:
  - `docs/studio/gameplay-spec.md`
  - `docs/studio/balance-sheet.md`
  - `docs/specs/components/<topic>.md`

## Player Promise

- What should the player understand?
- What should the player feel?
- What decision does this system create?
- What is intentionally out of scope?

## Inputs And Outputs

| Input | Source | Rule | Output | Consumer |
| --- | --- | --- | --- | --- |
| TBD | Player / timer / collision / resource | TBD | State / score / event / UI | TBD |

## State Model

| State | Entry Condition | Player Feedback | Exit Condition |
| --- | --- | --- | --- |
| Idle | TBD | TBD | TBD |
| Active | TBD | TBD | TBD |
| Resolved | TBD | TBD | TBD |

## Rules

1. TBD.
2. TBD.
3. TBD.

## Tunables

Every value here must also be registered in `balance-sheet.md` or a component
spec.

| Variable | Default | Min | Max | Tuning Signal |
| --- | --- | --- | --- | --- |
| TBD | TBD | TBD | TBD | TBD |

## Feedback Contract

| Event | Visual | Audio | UI | VFX |
| --- | --- | --- | --- | --- |
| System starts | TBD | TBD | TBD | TBD |
| Player succeeds | TBD | TBD | TBD | TBD |
| Player fails | TBD | TBD | TBD | TBD |

## Edge Cases

- What happens if the player leaves the area?
- What happens if the scene reloads?
- What happens if two triggers fire in the same frame?
- What happens on pause, restart, or game over?

## Godot 4.7 Implementation Notes

- Prefer typed GDScript and feature-local scenes.
- Use Callable signal syntax and `signal_name.emit(...)`.
- Use Resources for data that designers tune.
- Use `TileMapLayer` for 2D tile content.
- Use `user://` only for player settings, save data, or local runtime state.
- Query Context7 library `/websites/godotengine_en_4_7` before relying on
  version-sensitive engine behavior.

## Acceptance

- [ ] Player can explain the system after one use.
- [ ] Feedback exists for start, success, failure, and reset.
- [ ] Tunables have ranges and playtest signals.
- [ ] Edge cases have a defined behavior.
- [ ] Automated test or manual playtest route covers the system.

