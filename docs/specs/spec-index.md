# Spec Index

This file is the map for the project's living specifications. Use it before
adding new docs so the spec set stays small, discoverable, and useful.

## Core Specs

| File | Owns | Update When |
| --- | --- | --- |
| `docs/specs/project-context.md` | engine target, project boundary, current first playable | Godot version, first playable, or project target changes |
| `docs/specs/game-brief.md` | pitch, audience, player fantasy, pillars | the game idea or target player changes |
| `docs/specs/gdd.md` | canonical game design summary | mechanics, progression, or high-level content model changes |
| `docs/specs/architecture.md` | runtime architecture and module boundaries | scene structure, autoloads, data flow, dependencies, or 2D boundary changes |
| `docs/specs/first-playable.md` | playable slice acceptance criteria | first playable scope or done definition changes |
| `docs/specs/dev-plan.md` | production phases and sequencing | milestone strategy or workflow changes |
| `docs/specs/asset-list.md` | runtime assets, sources, licenses | any referenced asset, shader, audio, font, UI art, animation, or license changes |
| `docs/specs/polish-checklist.md` | final feel/readability/accessibility pass | feedback, juice, camera, UI, audio, or accessibility criteria change |
| `docs/specs/qa/test-plan.md` | automated and static validation | code behavior or test strategy changes |
| `docs/specs/qa/playtest-plan.md` | manual playtest route | playable flow, controls, level, or acceptance route changes |
| `docs/specs/change-log.md` | spec/runtime decision history | any meaningful iteration changes the project |

## Studio Specs

`docs/studio/` is the fixed game-soul surface. Fill it before production work
spreads across code, assets, levels, and tuning.

| File | Owns |
| --- | --- |
| `docs/studio/brainstorm-log.md` | concept options, pillars, prototype approaches |
| `docs/studio/grilling-gate.md` | challenged assumptions and scope cuts |
| `docs/studio/project-charter.md` | one-page promise, out-of-scope, stop/go gates |
| `docs/studio/gameplay-spec.md` | loop, verbs, mechanics, feedback, failure states |
| `docs/studio/balance-sheet.md` | tunables, ranges, rationale, playtest signals |
| `docs/studio/level-plan.md` | first level flow, blockout, pacing, teaching beats |
| `docs/studio/asset-production-plan.md` | 2D art, UI, animation, VFX, audio, import rules |
| `docs/studio/implementation-tickets.md` | buildable tickets and verification criteria |
| `docs/studio/system-sheet.md` | focused system rules, state model, edge cases, tunables, acceptance |
| `docs/studio/level-slice.md` | production-ready beat map, content table, metrics, playtest route |
| `docs/studio/tuning-pass.md` | one focused value/feel pass with before-after evidence |
| `docs/studio/playtest-report.md` | observed playtest findings, severity, actions, follow-up tickets |
| `docs/studio/content-audit.md` | asset/license/placeholder/import/release-readiness audit |

## Spec Components

Use `docs/specs/components/` when a topic is too detailed for the core docs but
does not deserve an architecture decision.

Good reasons to add one component spec:

- a feature has several states, edge cases, data resources, or acceptance tests
- a system affects multiple features, such as save/load, inventory, dialogue,
  combat, progression, camera, accessibility, or localization
- a level/content unit needs its own blockout, encounter, pacing, and asset notes
- an asset pack, animation set, VFX set, or audio set needs production tracking
- a dependency decision needs more context than the plugin catalog or ADR

Do not add a component spec for one-off text changes, small bug fixes, or values
already clear in `balance-sheet.md` or `implementation-tickets.md`.

## Component Naming

Create active component specs under:

```text
docs/specs/components/<topic>.md
```

Use lowercase snake_case names:

- `dash_ability.md`
- `save_system.md`
- `level_002.md`
- `combat_audio_pack.md`
- `dialogue_plugin_evaluation.md`

Copy from `docs/specs/components/TEMPLATE.md`.

## Required Cross-Links

When a component spec is added or materially changed:

1. Add an entry to `docs/specs/change-log.md`.
2. Link the component from the relevant core spec:
   - gameplay feature: `gdd.md` or `docs/studio/gameplay-spec.md`
   - system architecture: `architecture.md` and, when useful, `docs/studio/system-sheet.md`
   - level/content: `docs/studio/level-plan.md` and, when useful, `docs/studio/level-slice.md`
   - tuning: `docs/studio/balance-sheet.md` and `docs/studio/tuning-pass.md`
   - playtest evidence: `docs/specs/qa/playtest-plan.md` and `docs/studio/playtest-report.md`
   - assets/audio/VFX/UI: `asset-list.md`, `docs/studio/asset-production-plan.md`, and `docs/studio/content-audit.md`
   - plugin/dependency: `docs/third_party/plugin-catalog.md` or an ADR
3. Add or update QA coverage in `docs/specs/qa/`.
4. Add implementation work to `docs/studio/implementation-tickets.md`.

## Production Pass Routing

Use the Layer 2 studio docs before creating new component specs when the topic
fits on one focused sheet:

- System behavior, UI flow, enemy rules, save/load, economy, feedback loop:
  `docs/studio/system-sheet.md`.
- One level, room chain, arena, encounter, tutorial route, or content slice:
  `docs/studio/level-slice.md`.
- One focused change to values, difficulty, pacing, camera, input, reward, or
  feedback feel: `docs/studio/tuning-pass.md`.
- One manual playtest session or tester cohort:
  `docs/studio/playtest-report.md`.
- One milestone/release/open-source content sweep:
  `docs/studio/content-audit.md`.

If a Layer 2 sheet becomes too long, promote the details into
`docs/specs/components/<topic>.md` and link both documents.

## Iteration Rule

For each meaningful iteration, leave a trail:

```text
change-log entry -> affected core/studio spec -> optional component spec -> QA/playtest update
```

If the implementation changes behavior but no spec changed, either the change is
too small to matter or the docs are now stale. Choose one explicitly.

## Spec Takeover

The base template does not recommend or install a separate spec tool. If a
derived project replaces the local spec workflow:

1. Record the decision in `docs/decisions/`.
2. State the new active spec source of truth.
3. Map requirements, design, tasks, assets, QA, and release status back to the
   Godot docs listed above.
4. Resolve conflicts in an ADR before implementation continues.
