# Game Feel And Visual Polish

Use this reference whenever the user asks for better game effect, juice, polish, feel, fun, impact, readability, or production quality.

## Control Feel

- Add acceleration and deceleration instead of instant velocity when it improves control.
- Add jump buffering and coyote time for platformers.
- Keep attack, dodge, dash, and interact cooldowns visible through animation, UI, or sound.
- Avoid hidden delays between input and action unless the windup is intentional and readable.
- Expose tuning constants at the top of scripts or in resources.

## Feedback Layers

Core actions should usually have at least two feedback layers:

- Visual: flash, scale pulse, particles, trail, color shift, animation, damage number.
- Audio: click, pickup, hit, whoosh, confirm, fail.
- Motion: knockback, hit pause, shake, recoil, bounce, camera nudge.
- UI: counter change, health change, cooldown fill, toast, icon pulse.

Do not add effects that hide gameplay information. Readability beats spectacle.

## Camera

- Keep the next important target inside view.
- Use smoothing for exploration and lower lag for precision.
- Use small screen shake only for impact, damage, explosions, and major rewards.
- Clamp camera bounds in authored levels.
- For top-down action, bias the camera slightly toward movement or aim direction when useful.

## Animation And Timing

- Add anticipation before big actions.
- Add impact frames, hit pause, or slow motion for heavy hits.
- Add recovery so actions feel physical, but keep controls responsive.
- Use short loops for idle, run, attack, damage, death, pickup, level-up, and menu selection.
- Avoid uniform timing; mix short and medium durations so actions have rhythm.

## Visual Clarity

- Player, enemies, hazards, pickups, exits, and interactive objects must be distinguishable at a glance.
- Use stronger contrast for gameplay-critical objects than background decoration.
- Use consistent colors: danger, reward, interactable, disabled, selected, success.
- Do not let particles, bloom, shadows, or UI cover hazards or player state.

## UI Polish

- HUD should show health, score/resources, timer, objective, cooldowns, or prompts only when needed.
- Buttons need hover/pressed/disabled states.
- Menus need keyboard/gamepad navigation when targeting desktop.
- Text must not overlap at small resolutions.
- Use icon plus number for repeated gameplay resources when possible.

## Audio

- Add placeholder SFX early; silence makes prototypes feel broken.
- Use separate buses for master, music, SFX, and UI when the project grows.
- Give repeated actions slight pitch variation.
- Use music fades or stingers for game start, danger, success, failure, and level-up.

## Polish Pass Order

1. Fix readability and bugs.
2. Improve input response.
3. Add feedback for core actions.
4. Tune camera.
5. Add UI states.
6. Add audio.
7. Add particles/VFX.
8. Run a first-time-player playtest.
