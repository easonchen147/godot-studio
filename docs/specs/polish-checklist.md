# Polish Checklist

## Input And Feel

- [ ] Movement starts quickly.
- [ ] Movement stops or decays intentionally.
- [ ] Input buffering is defined where needed.
- [ ] Controller and keyboard controls are both checked if supported.
- [ ] Important actions have visible feedback within one frame or the intended animation beat.

## Camera

- [ ] Player and objective are readable.
- [ ] Camera does not jitter.
- [ ] Camera bounds match the level.
- [ ] Camera zoom supports UI and gameplay readability.

## Visual Feedback

- [ ] Interactables are recognizable.
- [ ] Hit/success/failure states are visually distinct.
- [ ] VFX do not hide gameplay-critical information.
- [ ] Color choices remain readable for accessibility.

## UI

- [ ] HUD shows only decision-critical information.
- [ ] Text fits at target resolutions.
- [ ] Focus states work for keyboard/gamepad.
- [ ] Pause/settings/result screens are reachable when implemented.

## Audio

- [ ] Music does not mask SFX.
- [ ] UI confirms selection and error states.
- [ ] Player actions have clear SFX.
- [ ] Ambient sound supports location without clutter.

## Performance

- [ ] No unnecessary `_process()` loops in idle nodes.
- [ ] Repeated spawn/despawn systems use pooling if needed.
- [ ] Dense scenes use visibility or distance gating.
- [ ] Target FPS is defined in `GameConfig`.

## Accessibility

- [ ] Text has sufficient contrast.
- [ ] Critical information is not color-only.
- [ ] Rebindable controls are planned.
- [ ] Screen reader or focus behavior is considered for Control-heavy UI.
