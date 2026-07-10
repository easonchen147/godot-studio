# Genre Templates

Use these templates to turn broad game ideas into a first playable Godot structure. Start small, then expand after the loop is fun.

## 2D Platformer

- Scenes: `Main`, `Player`, `Level01`, `Pickup`, `Hazard`, `Goal`, `HUD`.
- Scripts: player movement, jump buffering, coyote time, hazard reset, pickup counter, level finish.
- Feel knobs: acceleration, friction, jump height, coyote time, jump buffer, camera smoothing, landing particles.
- First playable: move, jump, collect one item, avoid one hazard, reach goal, restart on failure.
- Assets: player idle/run/jump, tile set, pickup, hazard, goal, UI counter, jump/collect/death sounds.

## Top-Down Action RPG

- Scenes: `Main`, `Player`, `Enemy`, `ProjectileOrHitbox`, `Room`, `HUD`, `Pickup`.
- Scripts: eight-way movement, attack cooldown, enemy chase, health, damage flash, pickups.
- Feel knobs: movement acceleration, attack windup, hit pause, knockback, invulnerability, enemy spawn spacing.
- First playable: move, attack one enemy, take damage, collect reward, survive or die, restart.
- Assets: player, enemy, attack slash/projectile, floor props, health UI, impact VFX, hit/death sounds.

## Roguelike Survival

- Scenes: `Main`, `Player`, `EnemySpawner`, `Enemy`, `XPDrop`, `UpgradeChoice`, `HUD`.
- Scripts: auto-attack or aimed attack, timed spawns, XP/level, upgrade selection, enemy scaling, game over.
- Feel knobs: enemy density, player speed, pickup magnet, attack cadence, hit flash, screen shake, level-up pause.
- First playable: survive 60 seconds, kill enemies, collect XP, choose one upgrade, lose and restart.
- Assets: player, 2 enemy types, XP gem, projectile, upgrade cards, timer, health bar, level-up sound.

## Tower Defense

- Scenes: `Main`, `Map`, `Path`, `Tower`, `EnemyWave`, `BuildUI`, `HUD`.
- Scripts: enemy path follow, tower targeting, projectile, currency, wave manager, build placement.
- Feel knobs: wave pacing, tower range, fire rate, projectile speed, enemy health, build cost, feedback color.
- First playable: place tower, start wave, enemies follow path, tower attacks, earn currency, base loses health.
- Assets: map, path, tower, enemy, projectile, range indicator, currency UI, build button, attack sound.

## Card Battle

- Scenes: `Main`, `Battle`, `Card`, `Hand`, `Enemy`, `IntentUI`, `Reward`.
- Scripts: draw/discard, energy, card effects, enemy intent, turn manager, status effects.
- Feel knobs: card drag response, hover scale, effect timing, damage number timing, enemy intent readability.
- First playable: draw hand, play attack/defense card, enemy acts, win or lose, show reward.
- Assets: card frame, icons, enemy, intent icons, damage numbers, button states, card play sounds.

## Visual Novel

- Scenes: `Main`, `DialogueUI`, `CharacterStage`, `ChoiceMenu`, `Background`.
- Scripts: dialogue runner, branching choices, character expressions, save state, history/log.
- Feel knobs: text speed, choice timing, expression transitions, music fade, background motion.
- First playable: read scene, make one choice, branch to two outcomes, return to title.
- Assets: background, character expressions, dialogue box, choice buttons, music, confirm/cancel sounds.

## Puzzle

- Scenes: `Main`, `PuzzleBoard`, `Piece`, `GoalState`, `HUD`, `LevelSelect`.
- Scripts: board state, input handling, undo, win detection, level data, hint or reset.
- Feel knobs: drag/snap timing, invalid move feedback, undo speed, completion celebration, level difficulty.
- First playable: solve one puzzle, reset, undo, win animation, next level placeholder.
- Assets: board, pieces, cursor/selection state, win effect, UI buttons, move/success sounds.

## Default First Playable Rule

Every template must include:

- A start state.
- One player-controlled verb.
- One obstacle or decision.
- One success state.
- One failure or retry state.
- Immediate visual and audio feedback for core actions.
