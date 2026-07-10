# Godot Engine Version Reference

| Field | Value |
|-------|-------|
| **Engine Version** | Godot 4.7 |
| **Project Pinned** | 2026-07-08 |
| **Last Docs Verified** | 2026-07-08 |
| **Primary Docs Source** | Context7 `/websites/godotengine_en_4_7` |
| **LLM Knowledge Cutoff** | May 2025 |

## Project Rule

This scaffold targets Godot 4.7. Do not write new implementation guidance for
older minor versions or generic Godot 4 wording unless the note is explicitly
historical.

Before changing APIs, project settings, import/export configuration, GDScript,
C#, GDExtension, shaders, or editor workflow guidance, query Context7 with
library `/websites/godotengine_en_4_7` when the behavior may be version-specific.

## Post-Cutoff Version Timeline

| Version | Release Window | Risk Level | Key Theme |
|---------|----------------|------------|-----------|
| 4.4 | 2025 | MEDIUM | FileAccess return types, shader texture type changes |
| 4.5 | 2025 | HIGH | Accessibility, variadic args, `@abstract`, shader baker, SMAA |
| 4.6 | 2026 | HIGH | Jolt default, glow rework, D3D12 default on Windows, IK restored |
| 4.7 | 2026 | HIGH | Project target; verify details through Context7 4.7 docs |

## Verified Sources

- Context7 Godot 4.7 docs: `/websites/godotengine_en_4_7`
- Official docs: https://docs.godotengine.org/en/4.7/
- Stable docs fallback: https://docs.godotengine.org/en/stable/
- Changelog: https://github.com/godotengine/godot/blob/master/CHANGELOG.md
