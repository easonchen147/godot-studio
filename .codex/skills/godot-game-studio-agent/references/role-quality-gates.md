# Role Quality Gates

Use these gates before calling a slice complete.

## Design Gate

- Player goal, main verb, obstacle, success state, and failure/retry state are clear.
- First playable scope is smaller than the user's full idea.
- Feature additions support the core loop or are deferred.

## Engineering Gate

- Engine is detected or explicitly chosen.
- Edited files match engine conventions.
- Runtime/editor check is named and run when available.
- No new parse, compile, missing resource, missing script, or broken reference errors are introduced.

## Engine Gates

- Godot: main scene launches, GDScript parse clean, resource paths valid, node ownership clear.
- Unity: Console has no new compile errors, edited scenes/prefabs avoid missing scripts, packages/input/render pipeline assumptions are recorded.
- Unreal: `.uproject` is valid, Blueprint/C++ compile status is checked when possible, gameplay framework classes are named clearly.

## Feel Gate

- Core actions have at least two feedback layers across visual, audio, motion, and UI.
- Controls respond within the expected genre feel.
- Camera frames the next useful gameplay target.

## Art Gate

- Player, enemy/obstacle, hazard, reward, and exit/interactable are visually distinct.
- Generated assets are stored inside project folders before use.
- Placeholder art does not confuse gameplay-critical objects.

## UI/UX Gate

- HUD shows only loop-critical state.
- Text fits at target and fallback resolutions.
- Buttons/prompts have clear default, hover/selected, pressed/active, and disabled states when applicable.

## Audio Gate

- Primary actions, reward, failure, and UI confirmation are not silent unless intentionally muted.
- Repeated SFX do not become distracting.
- Music/SFX/UI bus assumptions are documented when implemented.

## QA Gate

- A first-time-player script exists.
- Success and failure/retry paths are tested.
- Logs are checked after changes.
- Regression risk is recorded for any shared system.

## Release Gate

- Platform target is named.
- Export/build settings are checked for the detected engine.
- Known missing tooling is reported as a warning, not hidden.
