# Studio Documents

This directory is the fixed output surface for turning a game idea into a
buildable Godot 4.7 2D prototype. The goal is not paperwork for its own sake.
The goal is to give the game a clear soul before production work spreads across
code, assets, levels, UI, audio, and tuning.

Use `.codex/skills/godot-2d-game-studio/SKILL.md` before filling these files.

## Layer 1 - Game Soul And First Playable

Fill these first. They define what the game is and what the first playable must
prove.

| File | Owner | Purpose |
| --- | --- | --- |
| `brainstorm-log.md` | Creative Director + Game Designer | Explore concepts, pillars, references, and prototype approaches. |
| `grilling-gate.md` | Producer + QA Lead | Stress-test assumptions before implementation. |
| `project-charter.md` | Producer | One-page scope and first-playable promise. |
| `gameplay-spec.md` | Game Designer | Core loop, verbs, mechanics, feedback, failure states. |
| `balance-sheet.md` | Systems Designer | Tuning variables, ranges, rationale, playtest signals. |
| `level-plan.md` | Level Designer | First level flow, blockout, pacing, teaching beats. |
| `asset-production-plan.md` | Art Director + Audio Director | 2D art, UI, animation, VFX, music, SFX, import rules. |
| `implementation-tickets.md` | Technical Director | Buildable work slices and verification criteria. |

Recommended order:

1. `brainstorm-log.md`
2. `grilling-gate.md`
3. `project-charter.md`
4. `gameplay-spec.md`
5. `balance-sheet.md`
6. `level-plan.md`
7. `asset-production-plan.md`
8. `implementation-tickets.md`

## Layer 2 - Production Passes

Use these when the project moves from a rough idea into repeated production
passes. They stay lightweight and should only be filled when they clarify real
work.

| File | Owner | Use When |
| --- | --- | --- |
| `system-sheet.md` | Game Designer + Technical Director | A mechanic, UI flow, enemy, economy, save rule, or feedback loop needs explicit states, rules, edge cases, and acceptance. |
| `level-slice.md` | Level Designer + QA Lead | A specific level, room chain, arena, or tutorial route needs a production-ready beat map and playtest criteria. |
| `tuning-pass.md` | Systems Designer | A focused balance pass changes values and needs before/after evidence. |
| `playtest-report.md` | QA Lead + Producer | A playtest session should produce actionable observations and follow-up tickets. |
| `content-audit.md` | Producer + Art Director + Technical Artist | A milestone needs asset/license/placeholder/import cleanup before release or open-source publication. |

## Working Rule

When a game is small, each file can stay short. Do not expand scope just to fill
sections. If a topic becomes too detailed for these studio docs, copy
`docs/specs/components/TEMPLATE.md` into `docs/specs/components/<topic>.md` and
link it from the relevant studio/core spec.
