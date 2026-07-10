# Godot 4.7 2D Plugin Catalog

This catalog records useful third-party Godot components found during template
research. They are not installed by default. The starter should stay small and
vanilla until a specific game proves the need.

## Default Decision

Do not add mandatory plugins to the base scaffold beyond the curated GDQuest
MIT shader subset already stored under `assets/runtime/shaders/gdquest/`.

Reasons:

- The current template already runs, tests, and exports with vanilla Godot 4.7.
- Installed editor plugins increase upgrade and license maintenance surface.
- Small 2D prototypes often need different plugin mixes by genre.
- A plugin catalog gives agents a faster shortlist without bloating `addons/`.

## Recommended Shortlist

| Need | Candidate | Source | Why Consider It | Default Action |
| --- | --- | --- | --- | --- |
| Full editor/CI test framework | GdUnit4 | https://github.com/MikeSchulze/gdUnit4 | Godot 4 test framework with scene testing, assertions, mocks, and CI output. Exa results list compatibility with Godot 4.7 on upcoming/master line. | Keep optional; install when the project outgrows `tests/test_runner.gd`. |
| 2D camera feel | Phantom Camera | https://github.com/ramokz/phantom-camera | MIT camera addon inspired by Cinemachine; supports Camera2D follow, damping, framing, transitions, and zoom. | Optional for camera-heavy games. |
| Dialogue-heavy games | Dialogue Manager | https://github.com/nathanhoad/godot_dialogue_manager | Script-like nonlinear dialogue editor/runtime. Current v4 targets recent Godot 4 releases but notes release maturity caveat. | Optional; pin a stable release before use. |
| Visual novel/RPG dialogue | Dialogic | https://github.com/dialogic-godot/dialogic | MIT, mature dialogue/visual novel ecosystem with timeline tooling. | Optional; heavier than Dialogue Manager. |
| Enemy AI and behavior | BehaviourToolkit | https://github.com/ThePat02/BehaviourToolkit | MIT behavior tree/FSM/blackboard toolkit for Godot 4. | Optional once enemies need more than simple state nodes. |
| Lightweight FSM plugin | EasyStateMachine | https://github.com/IUXGames/EasyStateMachine | GDScript FSM addon with self-contained state nodes and inspector tooling. | Optional; current scaffold already has `shared/components/state_machine.gd`. |
| Experimental visual state graph | Synapse | https://github.com/gklompje/godot-synapse | Graph state machine for Godot 4.7+ Asset Store, but marked alpha. | Research-only; do not install by default. |

## Rejected For Base Install

| Candidate | Reason |
| --- | --- |
| Dialogue plugins | Genre-dependent and can register autoloads or custom resources that not every game needs. |
| AI behavior plugins | Not necessary until the project has enemies/NPCs with real behavior complexity. |
| Camera plugins | Current starter can ship a simple Camera2D first; add Phantom Camera when camera feel is a core feature. |
| Database plugins | Too genre-specific for a small 2D starter. Use Resources/JSON/ConfigFile first. |

## Install Checklist

When a derived game chooses a plugin:

1. Add plugin source under `addons/<plugin_name>/`.
2. Enable it in Godot Project Settings.
3. Add source, version, license, and rationale here.
4. Add a third-party notice if the plugin code is committed.
5. Add a small usage example or link to the feature that owns it.
6. Run `tools/godot/run-tests.ps1`.
7. Run `tools/godot/export-smoke.ps1` when export templates are available.
