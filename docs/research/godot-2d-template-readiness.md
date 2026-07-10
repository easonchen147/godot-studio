# Godot 4.7 2D Template Readiness Research

Date: 2026-07-09

## Verdict

The current `godot-studio` scaffold is ready as a small, copy-ready Godot 4.7
2D game development template.

It is not a full game generator and should not pretend to be one. Its value is
that a new game can start with:

- a runnable first playable loop,
- a production directory layout,
- local Godot 4.7 skills,
- a 2D expert-team workflow,
- fixed design/spec output documents,
- shader/VFX starter assets,
- test and export smoke wrappers,
- MIT license and open-source audit notes.

## Current Capability Check

| Area | Status | Evidence |
| --- | --- | --- |
| Engine target | Ready | `project.godot` pins Godot 4.7 feature metadata and local docs require Godot 4.7. |
| 2D runtime | Ready | Uses `CharacterBody2D`, `Area2D`, Control UI, 2D level sample, and CanvasItem shaders. |
| First playable | Ready | Boot -> AppShell -> main menu -> sample level -> pickup -> goal -> result screen. |
| Agent guide | Ready | `AGENTS.md` now states Godot 4.7, 2D-first boundaries, verification, plugin policy, and skill routing. |
| Project skills | Ready | `.codex/skills/` includes project, Godot, GDScript, C#, GDExtension, shader, game-studio, and 2D game-studio skills. |
| Game soul docs | Ready | `docs/studio/` contains fixed outputs for brainstorming, grilling, charter, gameplay, balance, level, assets, and tickets. |
| Asset pipeline | Ready | `assets/source/` vs `assets/runtime/`, 2D import rules, audio buses, shader subset, and asset registry are documented. |
| QA | Ready | The SceneTree runner verifies scaffold resources and the deterministic AppShell-to-restart first-playable contract. |
| Export | Ready with CI gate | Windows Desktop, Linux, and Web presets are committed; CI verifies all three while local hosts need matching target templates. |
| Open source | Ready | Root MIT `LICENSE`, third-party notices, plugin catalog, and open-source audit are included. |

## 2D-First Boundary

This template should be introduced as a 2D Godot 4.7 starter. Default work should
use:

- `Node2D`, `CharacterBody2D`, `Area2D`, `CollisionShape2D`, `Camera2D`;
- `Control`, `CanvasLayer`, and theme resources for UI;
- `TileMapLayer` and `TileSet` for tile levels;
- `shader_type canvas_item` for sprites/UI/screen effects;
- PNG/WebP sprites, spritesheets, tilesheets, WAV/OGG audio, TTF/OTF fonts.

3D, 2.5D, multiplayer, or live-service architecture should require an ADR.

## External Research Synthesis

### Godot 4.7 and Official Docs

Context7 over Godot docs supports these project decisions:

- Imported textures should be loaded through Godot resources (`res://`) rather
  than raw runtime file access for exported projects.
- CanvasItem shaders begin with `shader_type canvas_item`.
- Godot version-control guidance includes Git LFS patterns for binary image,
  audio, font, model, and Godot binary resource files.
- Tile work should use `TileMapLayer`; tilesets can include collision,
  navigation, and occlusion data when needed.
- 2D navigation exists through `NavigationServer2D` and `NavigationPolygon`.
- Audio import guidance favors WAV for short repetitive SFX and OGG Vorbis for
  music, speech, and long sounds.

Sources:

- https://github.com/godotengine/godot-docs
- https://docs.godotengine.org/en/4.7/

### Expert Team References

Useful ideas from the provided references:

- BMad Game Dev Studio: split quick prototype flow from full production flow;
  produce GDD, UX/design, technical architecture, production plan.
- Agency Agents: keep small but explicit roles for game design, level design,
  technical art, audio, narrative, and Godot implementation.
- Claude Code Game Studios: role catalog confirms useful coverage for producer,
  creative, art, audio, gameplay, systems, level, QA, release, and Godot
  specialists.
- Matt Pocock grilling: challenge one decision at a time and do not implement
  until assumptions are shared.
- Obra brainstorming: explore context, propose options, document the design,
  self-review the spec, and only then plan implementation.

Sources:

- https://github.com/bmad-code-org/bmad-module-game-dev-studio
- https://github.com/msitarzewski/agency-agents/tree/main/game-development
- https://github.com/Donchitos/Claude-Code-Game-Studios/tree/main/.claude/agents
- https://github.com/mattpocock/skills/tree/main/skills/productivity/grilling
- https://github.com/obra/superpowers/tree/main/skills/brainstorming

### Third-Party Component Research

The base template should not install large editor plugins by default. The useful
components are documented as optional:

- GdUnit4: install when the local smoke runner is not enough.
- Phantom Camera: install when camera feel becomes a core mechanic.
- Dialogue Manager/Dialogic: install for dialogue-heavy games.
- BehaviourToolkit/EasyStateMachine: install when enemy/NPC behavior outgrows
  local state-machine components.
- Synapse: interesting but alpha; research-only until stable.

Source catalog:

- `docs/third_party/plugin-catalog.md`

## Why The Template Is Sufficient For Full 2D Game Development

The scaffold now covers the whole path:

1. Idea shaping: `docs/studio/brainstorm-log.md`.
2. Design challenge: `docs/studio/grilling-gate.md`.
3. Project soul: `docs/studio/project-charter.md`.
4. Gameplay: `docs/studio/gameplay-spec.md`.
5. Numbers: `docs/studio/balance-sheet.md`.
6. Level design: `docs/studio/level-plan.md`.
7. Assets/audio/VFX: `docs/studio/asset-production-plan.md`.
8. Build slicing: `docs/studio/implementation-tickets.md`.
9. Runtime code: `game/`, `features/`, `shared/`.
10. QA: `tests/`, `tools/godot/`, `docs/specs/qa/`.
11. Export: `export_presets.cfg` and `tools/godot/export-smoke.ps1`.
12. Open source: `LICENSE`, `docs/open-source-audit.md`,
    `docs/third_party/`.

This is enough to build a complete small 2D game. It deliberately avoids
shipping preinstalled large plugins, asset packs, online services, analytics, or
3D systems because those are genre/project decisions.

## Remaining Known Gaps

- Local export smoke requires matching Godot 4.7 stable templates for the selected target; CI supplies the authoritative cross-platform export path.
- The current automated tests are scaffold smoke tests, not gameplay e2e input
  simulation.
- Placeholder visuals and audio should be replaced per project.
- Real projects must fill `docs/studio/` and `docs/specs/` before large feature
  expansion.
