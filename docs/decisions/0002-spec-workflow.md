# 0002 - Keep A Thin Local Spec Workflow

## Status

Accepted.

## Context

The starter needs a repeatable way to record change history and add a small
amount of feature-specific spec detail as a game evolves. It should not become a
spec-framework template. Godot remains the primary dependency.

## Decision

Use the thinnest useful local Markdown spec workflow:

- `docs/specs/spec-index.md` maps the living spec surface.
- `docs/specs/change-log.md` records meaningful design, technical, content,
  asset, QA, and release changes.
- `docs/specs/components/TEMPLATE.md` is the only local component template.
- `docs/specs/spec-index.md` also contains the short takeover rule for derived
  projects that replace the local workflow.

Do not name or recommend a specific external spec tool in the base workflow.

## Rationale

- The starter must remain copy-ready for Godot developers who only have Godot
  installed.
- The template already has game-specific documents for game soul, gameplay,
  balance, level design, asset planning, QA, and open-source publishing.
- A change log plus one generic component template is enough for this starter's
  intended base scale.
- If a derived project wants a different spec process, it should take over
  explicitly rather than running in parallel with ambiguous ownership.

## Consequences

- Every meaningful iteration must update `docs/specs/change-log.md`.
- New feature/system/content/asset/plugin complexity should create a component
  spec under `docs/specs/components/`.
- Agents must cross-link component specs from the owning core or studio spec.
- The workflow stays portable and reviewable as plain Markdown.
- Derived projects that replace the workflow must record ownership and mappings
  in an ADR before implementation continues.

## Rejected

- Add a named external spec tool to the base workflow.
  - Rejected because the base template should not push a non-Godot dependency or
    create a second source of truth.
- Keep multiple local component templates.
  - Rejected because the starter should stay minimal; one generic template is
    easier to maintain and adapt.
- Keep only ad hoc spec edits without a change log.
  - Rejected because long-running game iteration needs traceable decisions.
