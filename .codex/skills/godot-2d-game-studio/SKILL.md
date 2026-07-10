---
name: godot-2d-game-studio
description: Project-local Godot 4.7 2D game studio workflow. Use when shaping a new game idea, brainstorming a prototype, grilling design assumptions, defining gameplay, planning 2D assets/audio/VFX, level design, tuning numbers, implementation tickets, QA gates, or first-playable scope inside this template.
---

# Godot 2D Game Studio

This skill turns the starter into a small 2D game studio. It is intentionally
compact: enough roles and gates to build a complete game, without copying a
large agency framework into every project.

## Scope

- Engine: Godot 4.7.
- Default game shape: 2D desktop-first prototype.
- Primary language: typed GDScript.
- Runtime structure: `game/`, `features/`, `shared/`, `assets/`.
- Required output directory: `docs/studio/`.

For 3D, multiplayer, console, or large live-service games, create a new
architecture decision before expanding this skill.

## Required Reads

1. `AGENTS.md`
2. `docs/specs/project-context.md`
3. `docs/specs/architecture.md`
4. `docs/specs/spec-index.md`
5. `docs/studio/README.md`
6. Relevant document under `docs/studio/` or `docs/specs/components/`

## Studio Team

Use the smallest useful set.

| Role | Owns | Required Output |
| --- | --- | --- |
| Producer | Scope, milestone, risk, stop/go gates | `docs/studio/project-charter.md` |
| Creative Director | Player fantasy, pillars, tone, references | `docs/studio/brainstorm-log.md` |
| Game Designer | Core loop, verbs, mechanics, progression | `docs/studio/gameplay-spec.md` |
| Systems Designer | Numbers, tuning ranges, economy/resources | `docs/studio/balance-sheet.md` |
| Level Designer | Level intent, flow, blockout, pacing | `docs/studio/level-plan.md` |
| Technical Director | Godot architecture, dependencies, data flow | `docs/specs/architecture.md` or ADR |
| Godot Gameplay Scripter | Typed GDScript, scenes, signals, Resources | Feature scenes/scripts and tests |
| Art Director | 2D art style, readability, asset list | `docs/studio/asset-production-plan.md` |
| Technical Artist | Import settings, shaders, VFX, animation frames | `docs/specs/asset-list.md` |
| Audio Director | Music, SFX, ambience, bus routing | `docs/studio/asset-production-plan.md` |
| QA Lead | Test plan, playtest route, acceptance gates | `docs/specs/qa/` |

## Workflow

### 1. Brainstorm

Create or update `docs/studio/brainstorm-log.md`.

Capture:

- One-line pitch.
- Player fantasy.
- Three design pillars.
- Core verb candidates.
- 2-3 prototype approaches with tradeoffs.
- Recommended prototype approach.

Use brainstorming before creative work. Ask one question at a time only when a
real product decision cannot be inferred from existing docs.

### 2. Grilling Gate

Create or update `docs/studio/grilling-gate.md`.

Challenge:

- Is the core loop understandable in 60 seconds?
- Is every mechanic tied to a player decision or feeling?
- Are numbers marked as hypotheses until playtested?
- Are art/audio needs small enough for the first playable?
- Can the first level teach without long text?
- Can the feature be built with current template systems?

If the answer is no, reduce scope before implementation.

### 3. Prototype Charter

Write `docs/studio/project-charter.md`.

The charter is the project soul. It must fit on one page:

- What game is this?
- What should the player feel?
- What is the first playable?
- What is explicitly out of scope?
- What must be true before content expansion?

### 4. Gameplay Spec

Write `docs/studio/gameplay-spec.md`.

Use player-facing language first, implementation notes second:

- Moment-to-moment loop.
- Session loop.
- Inputs and verbs.
- Mechanics with purpose, state changes, edge cases, and failure states.
- Feedback contract for visuals, audio, UI, and VFX.

### 5. Balance Sheet

Write `docs/studio/balance-sheet.md`.

All values are hypotheses until playtested. Each tunable must include:

- Base value.
- Min/max.
- Rationale.
- Tuning signal.
- Owner feature/resource.

### 6. Level Plan

Write `docs/studio/level-plan.md`.

For 2D levels, specify:

- Tile size or world-unit grid.
- Camera framing.
- Critical path.
- Optional branch.
- Teaching beat.
- Reward beat.
- Failure/retry beat.
- Blockout checklist before art pass.

Prefer `TileMapLayer` for tile work and scene tiles only when a tile needs
interactive nodes.

### 7. Asset Production Plan

Write `docs/studio/asset-production-plan.md`.

Cover:

- Sprites, animation frames, UI, fonts, shaders/VFX.
- Music, SFX, ambience, stingers.
- Source paths under `assets/source/`.
- Runtime paths under `assets/runtime/`.
- Import settings and license/source notes.

Do not import non-commercial or unclear-license assets into the base template.

### 8. Implementation Tickets

Write `docs/studio/implementation-tickets.md`.

Each ticket must be independently buildable and testable:

- Goal.
- Files likely touched.
- Acceptance criteria.
- Godot verification.
- Playtest step.
- Rollback risk.

### 9. Spec Components And Change Trail

Use Layer 2 studio sheets for focused production passes before creating larger
component specs:

- `docs/studio/system-sheet.md` for one mechanic, UI flow, enemy, economy,
  save rule, or feedback loop with states, rules, edge cases, and acceptance.
- `docs/studio/level-slice.md` for one level, room chain, arena, encounter, or
  tutorial route with beats, content, metrics, and playtest criteria.
- `docs/studio/tuning-pass.md` for one value, difficulty, pacing, camera, input,
  reward, or feedback pass with before/after evidence.
- `docs/studio/playtest-report.md` for one manual playtest session or tester
  cohort with findings and follow-up tickets.
- `docs/studio/content-audit.md` for milestone, release, or open-source checks
  across assets, licenses, placeholders, imports, and generated files.

Use `docs/specs/spec-index.md` to decide whether a gameplay feature, system,
level/content unit, asset pack, or plugin evaluation needs a component spec.

Create component specs under `docs/specs/components/` by copying
`docs/specs/components/TEMPLATE.md` when the topic needs its own edge cases,
data model, assets, acceptance criteria, and QA route.

Update `docs/specs/change-log.md` whenever a meaningful iteration changes game
scope, mechanics, systems, content, assets, QA, dependencies, export behavior,
or release status.

### 10. QA And Release Gate

Update:

- `docs/specs/qa/test-plan.md`
- `docs/specs/qa/playtest-plan.md`
- `docs/production/sprint-status.yaml`

Run:

```powershell
tools\godot\run-tests.ps1
tools\godot\headless-check.ps1
```

Run `tools\godot\export-smoke.ps1` when matching Godot 4.7 stable export
templates are installed.

## Third-Party Component Rule

Use `docs/third_party/plugin-catalog.md` before adding any plugin. Default to
vanilla Godot unless the plugin removes a real bottleneck:

- GdUnit4 for full test suites.
- Phantom Camera for camera-heavy 2D feel.
- Dialogue Manager or Dialogic for dialogue-heavy games.
- BehaviourToolkit or similar only when enemy/NPC behavior outgrows the local
  state-machine components.

## Completion Standard

A prototype plan is ready when:

- `docs/studio/project-charter.md` states the game soul.
- `docs/studio/gameplay-spec.md` defines the first playable.
- `docs/studio/level-plan.md` defines the first level.
- `docs/studio/asset-production-plan.md` lists the minimum 2D assets and audio.
- `docs/studio/balance-sheet.md` marks all tunables as hypotheses.
- Production passes use `system-sheet.md`, `level-slice.md`, `tuning-pass.md`,
  `playtest-report.md`, or `content-audit.md` when those sheets reduce real
  ambiguity.
- QA docs contain a repeatable playtest route.
- The Godot project still passes the local runner.
