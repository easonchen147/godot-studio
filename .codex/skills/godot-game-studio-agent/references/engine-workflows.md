# Engine Workflows

Use this reference after routing roles. Prefer MCP/editor tools when available; otherwise use engine CLI, project files, and logs.

## Godot 4.7

- Project marker: `project.godot`.
- Main assets: scenes, GDScript, resources, materials, imported images/audio.
- Preferred bridge: GodotIQ MCP via `uvx godotiq`.
- Verify: run the main scene or project with the Godot console executable.
- Gate: no parse errors, no missing resources, main scene launches, node responsibilities are clear.

## Unity

- Project markers: `Assets/`, `Packages/manifest.json`, `ProjectSettings/ProjectVersion.txt`.
- Main assets: scenes, prefabs, C# scripts, ScriptableObjects, materials, packages, Input System settings.
- Preferred automation: Unity editor CLI when installed; otherwise use file checks and user-provided Console output.
- Verify: confirm project version, package manifest, compile status, missing script warnings, and scene/prefab references.
- Gate: no new compile errors, no missing scripts on edited prefabs/scenes, input mapping is explicit, render pipeline assumptions are recorded.

## Unreal Engine 5.x

- Project marker: `*.uproject`.
- Main assets: levels, Blueprints, C++ modules, actors, components, UMG widgets, config files.
- Preferred automation: Unreal Editor commandlets or editor Python when installed; otherwise use project structure and user-provided Output Log.
- Verify: `.uproject` parses, module/source layout is coherent, Blueprint/C++ compile status is checked when tools are available.
- Gate: GameMode/Pawn/PlayerController/HUD relationships are clear, edited Blueprints compile, C++ module assumptions are recorded.

## Unknown Engine

- Do not guess silently when implementation depends on engine APIs.
- Generate design docs and a starter plan only.
- Ask for engine choice if the prompt does not name Godot, Unity, or Unreal.
