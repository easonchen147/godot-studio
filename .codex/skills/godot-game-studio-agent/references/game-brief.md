# Game Brief Intake

Use this reference before starting a new game or when a vague idea needs to become a playable plan. Ask only the missing questions. If the user already gave enough direction, make reasonable assumptions and write them down.

## Minimum Questions

- Genre or closest reference game.
- Target platform: desktop, web, mobile, or prototype only.
- Perspective: 2D side view, 2D top-down, isometric, 3D third-person, 3D first-person, UI-driven.
- Core fantasy: what should the player feel powerful, curious, tense, clever, cozy, or funny doing?
- Main verb: move, jump, shoot, dodge, collect, build, match, choose, talk, solve, manage, race.
- First playable scope: what must be playable in the first 1 to 3 minutes?
- Art direction: pixel, clean vector, hand-painted, low-poly 3D, UI minimal, dark fantasy, cute, sci-fi, cozy.

## Documents To Create

Create or update these files inside the project:

- `docs/game-brief.md`: concept, audience, platform, controls, core loop, art direction, constraints.
- `docs/dev-plan.md`: first playable milestones, scene/script/resource changes, verification steps.
- `docs/asset-list.md`: required sprites, textures, UI, icons, VFX, audio, and placeholder policy.
- `docs/polish-checklist.md`: controls, feedback, camera, UI, audio, accessibility, export checks.

## Brief Shape

```markdown
# Game Brief

## Concept
- Title:
- Genre:
- Target platform:
- One-sentence pitch:
- Player fantasy:

## First Playable
- Goal:
- Core loop:
- Success state:
- Failure state:
- Expected session length:

## Controls
- Keyboard/mouse:
- Gamepad:
- Touch:

## Art And Audio
- Visual style:
- Palette:
- UI style:
- Audio mood:

## Constraints
- Must-have:
- Out of scope:
- Risks:
```

## Decision Rule

If a requested feature does not improve the first playable loop, player understanding, feedback, or production quality, defer it into `docs/dev-plan.md` as a later milestone.
