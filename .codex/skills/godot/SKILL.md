---
name: godot
description: >-
  Godot Engine 4.7 specialist: architecture patterns, scene/node design,
  signals, resources, autoloads, project settings, export presets, and
  engine-level decisions. Use when working on Godot 4.7 game projects for:
  (1) Designing scene/node architecture, (2) Deciding between GDScript, C#,
  and GDExtension, (3) Setting up autoloads or singletons, (4) Configuring
  project settings or export presets, (5) Reviewing Godot code for engine best
  practices, (6) Any general Godot 4.7 question. Query Context7 library
  /websites/godotengine_en_4_7 for version-sensitive details.
---

# Godot Engine Specialist

This project targets Godot 4.7. Use this skill for architecture, scenes,
nodes, Resources, signals, autoloads, project configuration, export presets,
and engine-level decisions.

## Version Rule

Training data may not include Godot 4.7. Before suggesting or changing any
version-sensitive API, setting, export option, import workflow, physics,
rendering, UI, animation, GDScript, C#, GDExtension, or shader behavior:

1. Read `references/VERSION.md`.
2. Read `references/godot-4-7-context7.md`.
3. Query Context7 library `/websites/godotengine_en_4_7` when the answer depends
   on current official docs.

Historical 4.4-4.6 notes in `references/` remain useful migration context, but
the implementation target for this scaffold is Godot 4.7.

## Language Decision Guide

| Language | Best For | Avoid For |
| --- | --- | --- |
| GDScript | Gameplay, scenes, UI, prototyping, iteration, most 2D logic | Heavy computation or data processing thousands of times per frame |
| C# | Complex systems, AI, data processing, test-heavy tooling | Simple scene behaviors needing fast iteration |
| GDExtension | Native libraries, SIMD, multithreading, measured hot paths | Game logic, prototypes, simple behaviors |

Prefer signals over direct cross-language method calls at language boundaries.

## Scene And Node Architecture

- Prefer composition over inheritance.
- Keep each scene self-contained and reusable.
- Use scenes for reusable runtime objects.
- Use Resources for data-driven content.
- Use `@onready` for node references that exist when the scene enters the tree.
- Avoid hardcoded distant node paths.
- Keep scene trees shallow enough to inspect quickly.
- Keep inheritance depth below 3 levels after the Godot base node type.

## Naming Conventions

GDScript:

- Files: `snake_case.gd`.
- Classes: `PascalCase` with `class_name` only for reusable types.
- Functions and variables: `snake_case`.
- Constants: `SCREAMING_SNAKE_CASE`.
- Signals: `snake_case`, past-tense event names when practical.
- Private members: `_private_name`.
- Scenes: `snake_case.tscn`.

C#:

- Files and classes: `PascalCase`.
- Public members: `PascalCase`.
- Private fields: `_camelCase`.
- Signal delegates: `PascalCaseEventHandler`.

## Resources

- Use custom `Resource` subclasses for items, abilities, stats, enemy data,
  level metadata, dialogue, and spawn tables.
- Save hand-authored data as `.tres`.
- Use `ResourceLoader.load_threaded_request()` for large assets.
- Duplicate shared Resources before mutating per-instance data.

## Signals

- Use signals for decoupled communication.
- Emit with `signal_name.emit(args)`.
- Connect with Callable syntax such as `button.pressed.connect(_on_pressed)`.
- Connect once in `_ready()` or setup methods, not in `_process()`.
- Prefer local direct signals for parent-child relationships.
- Prefer `SignalBus` only for cross-feature or global events.

## Autoloads

Use sparingly:

- `SignalBus`: global event hub.
- `GameState`: run/session state.
- `SceneLoader`: scene transition helper.
- `AudioManager`: music and SFX routing.
- `SaveManager`: only after persistent data exists.

Autoloads must not hold references to scene-specific nodes.

## Performance

- Disable `_process()` and `_physics_process()` when idle.
- Use Tweens/AnimationPlayer for animation instead of manual interpolation loops
  when practical.
- Pool frequently instantiated objects.
- Gate off-screen processing with visibility or distance checks.
- Profile with Godot's profiler before moving work to C# or GDExtension.

## Tooling

Ripgrep has no `gdscript` type. Use:

```powershell
rg --glob "*.gd" "pattern"
```

Do not use `rg --type gdscript`.
