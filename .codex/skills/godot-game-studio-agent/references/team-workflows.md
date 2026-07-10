# Team Workflows

Use these workflow teams for common tasks. Each team should produce acceptance criteria, role outputs, and verification notes.

## team-first-playable

- Roles: Executive Producer, Creative Director, Game Design Lead, Gameplay Lead, Engine Lead, Engine Specialist, Gameplay Programmer, QA Playtester.
- Output: one-minute loop, player verb, obstacle, success/failure, HUD, playtest script.
- Verify: engine launches or editor check runs; QA script completes or fails clearly.

## team-polish

- Roles: Creative Director, Art Director, Audio Director, Gameplay Lead, UI/UX Lead, Technical Art Lead, Game Feel Designer, Camera Designer, VFX Artist, Sound Designer, QA Playtester.
- Output: prioritized improvements for movement, camera, VFX, audio, UI, readability, and regression risk.
- Verify: core actions have feedback, camera frames action, UI remains readable, logs stay clean.

## team-combat

- Roles: Creative Director, Game Design Lead, Gameplay Lead, Combat Designer, Gameplay Programmer, Game Feel Designer, VFX Artist, Sound Designer, QA Playtester.
- Output: combat loop, damage rules, enemy behavior, hit feedback, fail/retry path.
- Verify: player can attack, be threatened, win/lose, understand feedback.

## team-ui

- Roles: Creative Director, UI/UX Lead, Engine Lead, UI Implementer, Accessibility Specialist, QA Playtester.
- Output: HUD/menu hierarchy, layout states, input prompts, accessibility notes.
- Verify: text fits, controls are clear, no gameplay-critical occlusion.

## team-art

- Roles: Art Director, Technical Art Lead, Sprite/Concept Artist, VFX Artist, Shader/Material Artist, Engine Specialist.
- Output: art direction, asset list, ImageGen prompts, import plan, replacement plan.
- Verify: assets are stored in project folders, imported cleanly, and visually readable.

## team-release

- Roles: Release Director, QA Director, Engine Lead, Tools/Pipeline Lead, Export Engineer, Documentation Producer, QA Playtester.
- Output: platform checklist, export/build settings, known blockers, release notes.
- Verify: engine-specific release gate is satisfied or missing tooling is explicitly reported.
