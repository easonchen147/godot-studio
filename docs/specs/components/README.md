# Spec Components

This directory is optional. Use it only when a topic is too detailed for the
core specs or `docs/studio/`.

Keep the local spec layer thin:

- one change log
- one spec index
- one generic component template

## Workflow

1. Copy `TEMPLATE.md` to `docs/specs/components/<topic>.md`.
2. Keep the file short.
3. Link it from the owning core or studio spec.
4. Add a `docs/specs/change-log.md` entry.
5. Update QA or playtest docs before implementation is called done.

Do not create new component types unless a derived project explicitly takes over
the spec workflow through an ADR.
