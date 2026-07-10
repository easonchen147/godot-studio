# Role Routing

Use this reference before implementation. Detect the engine first, then choose the smallest useful role set.

## Engine Specialists

- `godot`: Engine Lead + Godot Specialist.
- `unity`: Engine Lead + Unity Specialist.
- `unreal`: Engine Lead + Unreal Specialist.
- `unknown`: Executive Producer + Technical Director + Engine Lead. Ask or infer engine only after checking markers.

## Task Routes

| Task type | Directors | Leads | Specialists |
| --- | --- | --- | --- |
| New game idea | Executive Producer, Creative Director | Game Design Lead | Documentation Producer, Sprite/Concept Artist |
| Engine setup | Technical Director | Engine Lead, Tools/Pipeline Lead | Engine Specialist |
| First playable | Executive Producer, Creative Director | Game Design Lead, Gameplay Lead, Engine Lead | Engine Specialist, Gameplay Programmer, QA Playtester |
| Game effect polish | Creative Director, Art Director, Audio Director | Gameplay Lead, UI/UX Lead, Technical Art Lead | Game Feel Designer, Camera Designer, VFX Artist, Sound Designer, QA Playtester |
| Combat | Creative Director | Gameplay Lead, Game Design Lead | Combat Designer, Gameplay Programmer, Game Feel Designer, VFX Artist, Sound Designer, QA Playtester |
| UI/HUD/menu | Creative Director | UI/UX Lead, Engine Lead | UI Implementer, Accessibility Specialist, QA Playtester |
| Art/assets | Art Director | Technical Art Lead | Sprite/Concept Artist, VFX Artist, Shader/Material Artist, Engine Specialist |
| Bugfix | Technical Director, QA Director | Engine Lead | Engine Specialist, relevant Specialist, QA Playtester |
| Performance | Technical Director | Performance Lead, Engine Lead | Engine Specialist, Tools/Pipeline Lead |
| Release | Release Director, QA Director | Engine Lead, Tools/Pipeline Lead | Export Engineer, Documentation Producer, QA Playtester |

## Output Contract

Every routed task should state:

- Engine: `godot`, `unity`, `unreal`, or `unknown`.
- Task type.
- Assigned roles.
- Acceptance criteria.
- Engine-specific verification.
- Escalation owner if the task crosses design, tech, art, audio, QA, or release boundaries.

## Conflict Resolution

- Scope conflict: Executive Producer.
- Fun/readability conflict: Creative Director.
- Architecture/tooling conflict: Technical Director.
- Visual consistency conflict: Art Director.
- Audio feedback conflict: Audio Director.
- Test completeness conflict: QA Director.
- Build/platform conflict: Release Director.
