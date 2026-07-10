# Spec Change Log

This file is the lightweight history for design, technical, content, asset, QA,
and release decisions. Keep it current enough that another developer or agent
can resume the project without rediscovering why a spec changed.

Use this for meaningful project evolution, not for every typo.

## How To Use

Add one entry when any of these change:

- game scope, first playable promise, or core loop
- feature behavior, player verbs, enemies, items, UI flow, save/load, dialogue,
  level rules, progression, economy, or tuning
- asset pipeline, runtime asset list, import settings, shader/VFX boundary, or
  audio plan
- architecture, third-party plugin decisions, export target, or Godot version
- QA route, acceptance criteria, known risk, or release status

Each entry should name the spec files touched and the validation that proves the
change is safe enough for the current stage.

## Entry Template

```md
### YYYY-MM-DD - short-change-name

- Type: design | gameplay | system | level | asset | qa | tech | release
- Driver: why this changed
- Changed specs:
  - `docs/specs/...`
  - `docs/studio/...`
  - `docs/specs/components/...`
- Runtime impact: scenes, scripts, resources, assets, or exports affected
- Decision: what is now true
- Validation: command, playtest route, review, or not-run reason
- Follow-up: remaining risk or next ticket
```

## Current Baseline

### 2026-07-09 - godot-studio-starter-baseline

- Type: tech
- Driver: establish a copy-ready Godot 4.7 2D starter with AI-assisted game
  development workflow.
- Changed specs:
  - `README.md`
  - `AGENTS.md`
  - `docs/specs/project-context.md`
  - `docs/specs/architecture.md`
  - `docs/specs/dev-plan.md`
  - `docs/studio/`
  - `docs/third_party/`
- Runtime impact: baseline runnable pickup-goal sample, UI shell, debug overlay,
  GDQuest MIT shader subset, local test/export scripts.
- Decision: template remains Godot 4.7, 2D-first, vanilla Godot by default, with
  optional plugin catalog only.
- Validation: `tools/godot/run-tests.ps1`, `tools/godot/headless-check.ps1`, export smoke, and
  open-source scan were run during scaffold calibration.
- Follow-up: derived games should replace the sample loop and add feature-specific
  spec components when the core docs become too coarse.

### 2026-07-09 - thin-spec-workflow

- Type: tech
- Driver: support long-running iteration and change traceability without turning
  the Godot starter into a spec-framework template.
- Changed specs:
  - `docs/specs/spec-index.md`
  - `docs/specs/change-log.md`
  - `docs/specs/components/`
  - `docs/decisions/0002-spec-workflow.md`
  - `AGENTS.md`
  - `.codex/skills/godot-studio-project/SKILL.md`
  - `.codex/skills/godot-2d-game-studio/SKILL.md`
- Runtime impact: none.
- Decision: use a thin local Markdown workflow: spec index, change log, one
  generic component template, and a takeover rule for projects that replace the
  workflow.
- Validation: documentation structure and routing scans.
- Follow-up: if a derived game replaces the local spec process, add an ADR and
  record the new source of truth before implementation continues.

### 2026-07-09 - production-doc-layer-and-readme

- Type: tech / qa / design
- Driver: make the template production-grade enough for repeated 2D game
  development while keeping the local spec workflow lightweight and GitHub-ready.
- Changed specs:
  - `README.md`
  - `START_HERE.md`
  - `AGENTS.md`
  - `docs/studio/`
  - `docs/specs/spec-index.md`
  - `.codex/skills/godot-studio-project/SKILL.md`
  - `.codex/skills/godot-2d-game-studio/SKILL.md`
  - `tools/godot/headless-check.ps1`
- Runtime impact: none.
- Decision: add and route a thin Layer 2 production-document layer for system
  sheets, level slices, tuning passes, playtest reports, and content audits.
- Validation: static scans, documentation presence checks, privacy/license
  scans, and Godot 4.7 smoke checks during final calibration.
- Follow-up: derived games should fill these sheets only when they reduce
  ambiguity; otherwise keep using the core studio docs and change log.

### 2026-07-10 - continuous-delivery-baseline

- Type: qa / release / tooling
- Driver: close the remaining delivery gaps without adding a runtime framework or third-party test dependency.
- Changed specs: first playable, QA plan, development plan, project context, onboarding, readiness research, and production status.
- Runtime impact: no production gameplay architecture change; the sample loop now has automated public-seam integration coverage.
- Decision: commit Windows Desktop, Linux, and Web export presets; use target-aware local smoke checks and GitHub Actions as the cross-platform export gate.
- Validation: Godot 4.7 test runner, headless load, Windows/Web export smoke, expected local Linux template prerequisite, and CI workflow inspection.
- Follow-up: add browser/device QA when a derived project claims Web/mobile support.

### 2026-07-11 - continuous-delivery-calibration

- Type: qa / release / tooling
- Driver: make the portable CI workflow execute from the template root and keep archive verification trustworthy when GitHub Actions restores cached downloads.
- Changed specs: CI workflow, onboarding, project context, development plan, and README export guidance.
- Runtime impact: none.
- Decision: cache only Godot archives; fetch the official SHA512 manifest fresh on every CI run, and run checksum verification from the archive cache directory before extracting or exporting.
- Validation: workflow YAML parse, CI root/path static checks, Godot 4.7 runner and headless load, Windows/Web export smoke, and Linux template prerequisite diagnostic.
- Follow-up: GitHub Actions remains the execution authority for the Linux artifact and complete hosted CI matrix.
