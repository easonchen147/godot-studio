# Content Audit

Use this template before a milestone, release, repository cleanup, or asset
import pass. It checks whether content is usable, licensed, tracked, and
connected to the game.

## Audit Scope

- Date: YYYY-MM-DD.
- Auditor: Producer / Art Director / Technical Artist / QA Lead.
- Scope: all content / level / UI / audio / shader / third-party / export.
- Related docs:
  - `docs/specs/asset-list.md`
  - `docs/studio/asset-production-plan.md`
  - `docs/open-source-audit.md`
  - `docs/third_party/`

## Content Register

| Asset/System | Runtime Path | Source Path | License | Status | Notes |
| --- | --- | --- | --- | --- | --- |
| TBD | `assets/runtime/...` | `assets/source/...` | TBD | placeholder / approved / blocked | TBD |

## Coverage Checklist

- [ ] Every runtime asset appears in `docs/specs/asset-list.md`.
- [ ] Every third-party source has license/source notes.
- [ ] Non-commercial or unclear-license assets are excluded.
- [ ] Editable source files are under `assets/source/`.
- [ ] Runtime files are under `assets/runtime/`.
- [ ] Godot `.import` sidecars are committed when generated.
- [ ] `.godot/imported/`, `build/`, `exports/`, and local user data are not committed.
- [ ] Audio routes through the intended bus.
- [ ] Shader/VFX files have a purpose and owner.
- [ ] Placeholder assets are marked clearly.

## Blockers

| Blocker | Impact | Owner | Next Action |
| --- | --- | --- | --- |
| TBD | TBD | TBD | TBD |

## Cleanup Actions

| Action | File/Folder | Reason | Done |
| --- | --- | --- | --- |
| TBD | TBD | TBD | no |

## Decision

- Content is ready / needs cleanup / blocked.
- Follow-up change-log entry: yes / no.

