# Godot Studio Agent Guide

This folder is a portable Godot 4.7 starter project. Treat this file as the operating contract for any AI agent working inside the project.

## Non-Negotiables

- Target Godot 4.7 for docs, code, project settings, exports, and review comments.
- This starter is 2D-first. Default to `Node2D`, `Control`, `CharacterBody2D`,
  `Area2D`, `CollisionShape2D`, `Camera2D`, `TileMapLayer`, CanvasItem shaders,
  and 2D asset/audio/UI workflows.
- Do not add 3D gameplay, 3D physics, 3D cameras, 3D models, multiplayer, or
  live-service architecture unless a new decision record explicitly changes
  the project target.
- When an API or engine behavior is uncertain, use Context7 library `/websites/godotengine_en_4_7` before changing code.
- Preserve a runnable first playable: move the player, collect the pickup, reach the goal, receive feedback.
- Keep feature code near the feature scene. Do not recreate the old flat `scenes/` plus `scripts/` layout.
- Use typed GDScript, Callable signal syntax, `await`, Resources for data, and scenes for reusable runtime objects.
- Verify with the Godot CLI/editor when available. If runtime validation cannot run, report the gap.

## Project-Local Skills

Load only the skill needed for the current task:

| Task | Skill |
| --- | --- |
| Project workflow and scaffold rules | `.codex/skills/godot-studio-project/SKILL.md` |
| 2D game concept, prototype docs, expert team workflow | `.codex/skills/godot-2d-game-studio/SKILL.md` |
| Godot architecture, scenes, resources, autoloads, export | `.codex/skills/godot/SKILL.md` |
| GDScript implementation and review | `.codex/skills/godot-gdscript/SKILL.md` |
| C# gameplay/systems code | `.codex/skills/godot-csharp/SKILL.md` |
| GDExtension/native hot paths | `.codex/skills/godot-gdextension/SKILL.md` |
| Shaders, materials, VFX | `.codex/skills/godot-shader/SKILL.md` |
| Studio roles, first playable, playtest, asset pipeline | `.codex/skills/godot-game-studio-agent/SKILL.md` |

When a skill references `references/`, read only the relevant reference file for the current work.

## Required Context Before Edits

Before changing code, scenes, resources, or project settings, read:

1. `docs/specs/project-context.md`
2. `docs/specs/architecture.md`
3. `docs/specs/spec-index.md`
4. The relevant `.tscn`, `.gd`, `.tres`, asset, component, or spec files.

For substantial features, also update:

- `docs/specs/change-log.md`
- `docs/specs/dev-plan.md`
- `docs/specs/asset-list.md`
- `docs/specs/qa/test-plan.md`
- `docs/specs/qa/playtest-plan.md`
- `docs/studio/system-sheet.md` for mechanics, UI flows, enemies, economy,
  save/load, feedback loops, or other systems with real states and edge cases.
- `docs/studio/level-slice.md` for production-ready level, room chain, arena,
  encounter, or tutorial slices.
- `docs/studio/tuning-pass.md` after focused value, pacing, economy, difficulty,
  camera, input, or feedback tuning.
- `docs/studio/playtest-report.md` after meaningful manual playtests.
- `docs/studio/content-audit.md` before milestones, release candidates, or
  open-source publication.
- `docs/specs/components/` when a feature, system, content unit, asset pack,
  or third-party evaluation needs its own spec.
- `docs/decisions/` when an architecture or pipeline decision is made.

## Research And Troubleshooting Protocol

When a Godot development problem appears, do not guess from memory when the
answer depends on engine behavior, import/export settings, rendering, UI focus,
input handling, or version-specific API details.

Use this order:

1. Read the local context first:
   - relevant `.gd`, `.tscn`, `.tres`, and `project.godot`
   - `docs/specs/project-context.md`
   - `docs/specs/architecture.md`
   - `docs/specs/asset-list.md`
   - `docs/specs/qa/test-plan.md` and `playtest-plan.md`
2. Query official Godot 4.7 docs through Context7 library
   `/websites/godotengine_en_4_7` for version-sensitive behavior.
3. Read the project-local Godot skill references under
   `.codex/skills/godot/references/` when the problem is architectural,
   migration-related, or subsystem-specific.
4. Reproduce and validate with the strongest practical runtime check:
   - `.\tools\godot\run-tests.ps1`
   - `.\tools\godot\headless-check.ps1`
   - `.\tools\godot\export-smoke.ps1`
   - `C:\Godot\Godot_v4.7-stable_win64_console.exe -d --path .`
5. Only after vanilla Godot and official docs are understood, evaluate optional
   third-party components via `docs/third_party/plugin-catalog.md`.

Use Context7 proactively for:

- GDScript, C#, GDExtension, shader, input, UI, animation, physics, and audio APIs.
- Control focus, keyboard/gamepad navigation, and UI interaction bugs.
- Import rules, export presets, rendering options, and command-line behavior.
- Any issue where Godot 4.7 details matter more than generic Godot 4 memory.

When reporting an answer or fix, include:

- what the local project is doing now,
- what the official Godot 4.7 docs say,
- what command or scene was used to verify the result,
- and any remaining uncertainty or host limitation.

## Production Directory Contract

```text
game/                 Engine entrypoints and global runtime services.
  boot/               Canonical project entry; initializes and routes into AppShell.
  app/                AppShell scene that owns menu/gameplay/support screen routing.
  main/               Sample gameplay composition loaded by AppShell.
  autoload/           True global services only.

features/             Product features. Scenes, scripts, and local resources stay together.
  player/
  pickups/
  goals/
  levels/level_001/
  ui/hud/
  ui/menu/
  ui/results/
  ui/debug/
  vfx/shader_showcase/

shared/               Cross-feature reusable code only.
  components/
  resources/
  states/
  utils/

assets/
  runtime/            Imported/runtime assets referenced by scenes.
  source/             Editable art/audio/model/source files. Contains `.gdignore`.
  import_presets/     Import settings and pipeline notes.

addons/               Godot plugins.
tests/                Unit, integration, and e2e checks.
tools/                External pipeline and CI scripts. Contains `.gdignore`.
docs/                 Specs, ADRs, plans, QA docs. Contains `.gdignore`.
  studio/             Fixed output docs for brainstorming, grilling, prototype,
                      gameplay, balance, level, asset, system, tuning,
                      playtest, content audit, and ticket planning.
  specs/components/   Optional modular specs for features, systems, content,
                      asset packs, and third-party evaluations.
```

Do not place new runtime code under root-level `scenes/` or `scripts/`. If those folders reappear, treat them as migration debt unless a documented decision says otherwise.

## Godot 4.7 Coding Rules

- Prefer GDScript for gameplay, scenes, UI, and fast iteration.
- Use explicit types for variables, parameters, return values, and arrays.
- Use `class_name` only for reusable types that other scripts should reference.
- Use `@export` and typed Resources for tunable data.
- Use `@onready` for node references that exist when the scene enters the tree.
- Use Callable signal syntax: `button.pressed.connect(_on_pressed)`.
- Emit signals with `signal_name.emit(...)`.
- Use `await`, never Godot 3 `yield`.
- Use `FileAccess` and `DirAccess`, not Godot 3 `File` and `Directory`.
- Prefer `TileMapLayer` for new tile work.
- Avoid long `$../../Node` paths. Prefer feature-local nodes, exported references, unique names, groups, or signals.
- Do not mutate physics monitoring/collision state directly inside physics callbacks; defer with `set_deferred()` or `call_deferred()`.
- Autoloads must not hold references to scene-specific nodes.

## Scene Architecture

Default runtime shape:

```text
project.godot
  game/boot/boot.tscn
    game/app/app_shell.tscn
      MainMenu / OptionsMenu / CreditsScreen / PauseMenu / ResultScreen / DebugOverlay
      ContentRoot
        game/main sample gameplay scene
          LevelRoot
          HUD
```

Reusable feature scene shape:

```text
FeatureRoot
  CollisionShape2D
  Visuals
  Components
  States
  Debug
```

Use scenes for reusable runtime objects, Resources for data, and autoloads only for true global services such as `SignalBus`, `SettingsManager`, `GameState`, `AudioManager`, and `SceneLoader`.

## Asset Pipeline

Use this split:

- `assets/source/art/` for editable PSD/Krita/Aseprite/concept/reference art.
- `assets/source/audio/` for DAW sessions, raw recordings, stems, and references.
- `assets/source/blender/` only for optional 2.5D/3D source experiments after an ADR.
- `assets/runtime/sprites/`, `tilesets/`, `textures/`, `ui/`, `vfx/`, `shaders/`, `fonts/` for default 2D runtime art.
- `assets/runtime/audio/music/`, `sfx/`, `ambience/` for runtime audio.
- `assets/runtime/shaders/gdquest/` for the bundled GDQuest MIT shader subset.

After adding assets:

1. Use stable lowercase snake_case names.
2. Keep editable sources under `assets/source/`.
3. Put engine-ready runtime files under `assets/runtime/`.
4. Import through Godot when possible.
5. Commit runtime source files and generated `.import` sidecar metadata.
6. Do not commit `.godot/imported/`.
7. Update `docs/specs/asset-list.md`.
8. For third-party shader libraries, keep license notices under the runtime
   shader folder and summarize source/license boundaries in `docs/third_party/`.

## Development Lifecycle

Use this order for AI-assisted development:

1. Brief: update `docs/specs/game-brief.md`.
2. Studio design: use `.codex/skills/godot-2d-game-studio/SKILL.md` and fill
   `docs/studio/` in order.
3. Spec routing: read `docs/specs/spec-index.md`; create a component spec by
   copying `docs/specs/components/TEMPLATE.md` only when the change is too
   detailed for the core docs.
4. Technical design: update `docs/specs/gdd.md`, `architecture.md`, and
   `asset-list.md`.
5. Vertical slice: keep `features/levels/level_001/` playable.
6. Production pass: use `system-sheet.md`, `level-slice.md`, `tuning-pass.md`,
   `playtest-report.md`, or `content-audit.md` when they reduce ambiguity, then
   add feature modules, data Resources, runtime assets, and tests.
7. Change trail: update `docs/specs/change-log.md` for meaningful iterations.
8. Polish: use `docs/specs/polish-checklist.md`.
9. QA: run `docs/specs/qa/test-plan.md` and `playtest-plan.md`.
10. Export: update `export_presets.cfg` and verify release builds.

## Third-Party Components

Do not install new addons by default. First check
`docs/third_party/plugin-catalog.md`, then add a plugin only when it solves a
specific project need. Record source, version, license, install path, and why
vanilla Godot is insufficient.

## Verification

Use the strongest available verifier:

1. `.\tools\godot\run-tests.ps1`
2. `.\tools\godot\headless-check.ps1`
3. `.\tools\godot\export-smoke.ps1`
4. Manual playtest script in `docs/specs/qa/playtest-plan.md`.
5. Static inspection and path search when the Godot CLI cannot run.
6. For fast-moving runtime bugs, use `C:\Godot\Godot_v4.7-stable_win64_console.exe -d --path .` to keep debugger output visible.

`export-smoke.ps1` requires matching Godot `4.7.stable` export templates. If
they are not installed under `%APPDATA%\Godot\export_templates\4.7.stable`, pass
`-ExportTemplatesRoot` to a cache containing the Windows templates and report any
remaining host setup gap explicitly.

Before completion, search for old paths and stale versions:

```powershell
rg -n "Godot 4[.]6|res://scene[s]|res://script[s]|emit_signal[(]|[.]instance[(]|yield[(]" .
```

## Completion Standard

A change is done only when:

- The project remains runnable.
- The main scene loads.
- The first playable loop is preserved or intentionally updated.
- New behavior has a test or manual playtest step.
- Specs reflect new systems, assets, risks, and open work.
- `docs/specs/change-log.md` records meaningful spec/runtime changes.
- New component complexity is captured under `docs/specs/components/` or
  explicitly kept in a core spec.
- No unrelated files were churned.
