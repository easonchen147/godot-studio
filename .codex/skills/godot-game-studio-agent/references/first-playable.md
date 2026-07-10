# First Playable Standard

Use this reference to decide what to build before adding scope. A first playable is a tiny complete game loop, not a feature pile.

## Required Elements

- The player knows what they control within 5 seconds.
- The player has one clear goal.
- The core verb works with responsive input.
- The world reacts visibly to player actions.
- There is a win, reward, fail, or restart state.
- The HUD shows only information needed for the loop.
- The game can be relaunched without manual editor steps.

## Minute-One Checklist

- Camera frames the player and the next useful target.
- Control mapping is obvious or displayed through UI labels.
- First obstacle is visible before it harms the player.
- First reward is reachable quickly.
- Failure explains itself through animation, sound, UI, or reset behavior.
- There are no silent interactions: pickups, hits, menu actions, and state changes all provide feedback.

## Scope Control

Build in this order:

1. Player movement or primary interaction.
2. One object or enemy that responds.
3. One goal or scoring condition.
4. One failure or reset condition.
5. HUD for only the current loop.
6. Basic game-feel pass.
7. One art pass that clarifies the scene.

Defer progression systems, shops, large maps, multiple enemy types, save systems, and complex menus until the loop is playable.

## Done Definition

A first playable is done when Codex can describe a repeatable playtest script and the project can run through that script without parse errors, missing resources, or confusing feedback.
