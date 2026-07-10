# Game Design Document Template

## Summary

- Title: TBD
- Genre: TBD
- Target session length: TBD
- Target audience: TBD
- Primary platform: TBD
- Dimension: 2D by default

This template targets 2D games. Use `docs/studio/` to define the prototype
soul, gameplay, level, balance, and asset plan before replacing the sample loop.

## Core Loop

Describe the 30-second loop:

1. Player action.
2. System response.
3. Reward or consequence.
4. Next decision.

Describe the 5-minute loop:

1. TBD
2. TBD
3. TBD

## Controls

| Action | Keyboard | Gamepad | Touch |
| --- | --- | --- | --- |
| Move | WASD / Arrow Keys | Left Stick | TBD |
| Interact | E | TBD | TBD |
| Jump | Space | TBD | TBD |
| Pause | Escape | Start | TBD |

## Player

- Movement model: TBD
- Health/failure rules: TBD
- Abilities: TBD
- Upgrade path: TBD
- Animation states: idle, move, interact, hit, fail, success, TBD

## World And Levels

For each level:

- Objective
- Layout sketch
- Critical path
- Optional path
- Hazards
- Pickups/rewards
- Enemy placement
- Camera behavior
- Performance risks

Prefer `TileMapLayer`, `Node2D`, `Area2D`, and `Camera2D` for the default level
pipeline.

## UI

Required UI surfaces:

- HUD
- Pause menu
- Settings menu
- Main menu
- Results/failure screen
- Dialogue or tutorial prompts

For each UI surface, specify:

- Information hierarchy
- Input method
- Accessibility requirements
- Required icons/fonts/textures
- Audio feedback

## Audio

Required audio categories:

- Music
- UI SFX
- Player action SFX
- Environment ambience
- Enemy or hazard SFX
- Success/failure stingers

## Art And Animation

Required asset categories:

- Character sprites or model
- Animation frames or rigs
- Tilesets or modular environment models
- Props and pickups
- UI panels, icons, cursors
- VFX sprites, particles, shaders
- Promotional/key art if needed

For the default 2D path, prefer sprites, spritesheets/atlases, tilesheets,
CanvasItem shaders, and UI textures. 3D models are optional extension work, not
part of the base target.

## Economy And Progression

TBD.

## Narrative

TBD.

## Technical Risks

Track engine, performance, AI generation, asset import, shader, export, and save-system risks here.
