# Agent System

This file is the compatibility entrypoint for the studio role system. For new work, use:

- `references/studio-structure.md` for the three-tier studio hierarchy.
- `references/role-routing.md` for task-to-role assignment.
- `references/role-quality-gates.md` for acceptance gates.
- `references/team-workflows.md` for common team routes.
- `agents/roles/` for individual role cards.

## Operating Pattern

1. Detect or choose the engine: Godot, Unity, Unreal, or unknown.
2. Classify the task: concept, setup, first playable, polish, combat, UI, art, bugfix, performance, or release.
3. Load the smallest useful role set from `role-routing.md`.
4. Use role cards to produce concrete outputs and escalation owners.
5. Verify with the engine-specific workflow and quality gates.
6. Close the slice only when the player can understand the goal, perform the core action, see feedback, and complete or fail a short loop.

## Godot Notes

Godot remains the deepest supported path in this skill. Prefer GodotIQ MCP when available, keep GDScript and scene edits small, and run the project often.

## Unity Notes

Unity support focuses on detection, routing, project documentation, C# and scene/prefab guidance, package/input/render-pipeline checks, and Console-driven verification. Use editor automation only when confirmed available.

## Unreal Notes

Unreal support focuses on detection, routing, project documentation, C++/Blueprint/gameplay-framework guidance, UMG awareness, and Output Log or commandlet verification. Use editor automation only when confirmed available.
