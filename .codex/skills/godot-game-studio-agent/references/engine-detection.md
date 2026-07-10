# Engine Detection

Use `scripts/detect-game-engine.ps1` when possible. When inspecting manually, use these markers.

## Godot

Detect as `godot` when the project root contains:

- `project.godot`

Common supporting folders:

- `scenes/`
- `scripts/`
- `addons/`
- `assets/`

## Unity

Detect as `unity` when the project root contains at least two of:

- `Assets/`
- `Packages/manifest.json`
- `ProjectSettings/ProjectVersion.txt`

Common supporting folders:

- `Packages/`
- `ProjectSettings/`
- `UserSettings/`

## Unreal

Detect as `unreal` when the project root contains:

- one `*.uproject` file

Common supporting folders:

- `Content/`
- `Source/`
- `Config/`
- `Plugins/`

## Unknown

Return `unknown` when none of the markers are present. Do not create Unity or Unreal projects automatically unless the relevant editor tooling is detected and the user explicitly asked for project creation. For unknown directories, create only starter docs and ask or infer the engine from the user's prompt.
