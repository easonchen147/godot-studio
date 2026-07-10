# Development Loop

Use this loop for every Godot, Unity, or Unreal implementation or debugging task.

## Observe

- Detect the engine with `scripts/detect-game-engine.ps1`.
- Locate the relevant scenes/levels, scripts/classes, prefabs/blueprints/resources/assets, and project settings.
- Use MCP/editor tools when available to inspect project state, scene tree, runtime state, and logs.
- If MCP/editor automation is unavailable, read files directly and use engine CLI/editor logs or user-provided output.

## Plan

- Define the smallest playable or verifiable slice.
- For game work, define the player verb, goal, feedback, fail state, and success state before editing.
- Decide whether the change belongs in a scene/level, script/class, prefab/blueprint/resource, asset, project setting, or export/build preset.
- Name the expected verification command or runtime behavior before editing.

## Edit

- Keep engine-specific edits scoped.
- Use ImageGen for bitmap assets when visual quality matters; save final files under `assets/` or `art/`.
- Do not reference generated images from their default ImageGen storage path.

## Run

Run the project or a specific scene when the engine tools are available. For Godot:

```powershell
$godot = & "<skill-root>\scripts\check-godot-env.ps1" -ProjectPath "<project-root>" -ShowGodotPathOnly
& $godot --path "<project-root>" --quit-after 3
```

For editor import checks, open the editor once after adding new art assets.

For Unity, use Unity editor/CLI checks when available and inspect Console output. For Unreal, use Unreal Editor commandlets/editor checks when available and inspect Output Log.

## Inspect Logs

- Read console output, editor output, and MCP debug output.
- Fix parse/compile errors, missing node paths, missing resources, missing scripts, broken references, and signal/event connection failures before continuing.
- If Godot starts but behavior is wrong, instrument with focused `print()` statements and remove them once stable unless they are useful diagnostics.

## Verify

- Rerun after each fix.
- Confirm the acceptance criteria in plain language.
- Confirm the first-time-player path: what the player sees, does, understands, receives as feedback, and how the loop ends or repeats.
- Apply the relevant checks from `references/game-feel.md` and `references/playtest-qa.md` before calling a playable slice done.
- For export tasks, run the export command or validate export presets before calling the task done.
