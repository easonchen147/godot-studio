# Asset Production Plan

## 2D Visual Style

- Style target: TBD.
- Pixel art: TBD.
- HD/vector art: TBD.
- Camera scale/base resolution: TBD.
- Contrast/readability rules: TBD.

## Runtime Asset Rules

| Asset | Preferred Format | Runtime Path | Source Path | Import Notes |
| --- | --- | --- | --- | --- |
| Sprites | PNG/WebP | `assets/runtime/sprites/` | `assets/source/art/` or `assets/source/aseprite/` | Use lossless for pixel art. Commit `.import` sidecars. |
| Animation frames | PNG atlas or spritesheet | `assets/runtime/sprites/<actor>/animations/` | `assets/source/aseprite/` | Prefer atlas/spritesheet over one file per frame. |
| Tilesets | PNG tilesheet | `assets/runtime/tilesets/` | `assets/source/art/` | Use `TileMapLayer`; define collision/navigation/occlusion layers when needed. |
| UI icons/panels | PNG/WebP/SVG | `assets/runtime/ui/` | `assets/source/art/` | Include normal/hover/pressed/disabled/focused states. |
| Fonts | TTF/OTF | `assets/runtime/fonts/` | licensed source package | Record license and fallback. |
| Shaders | `.gdshader` | `assets/runtime/shaders/` | shader source | Use `canvas_item` for 2D. |
| VFX sprites | PNG/WebP | `assets/runtime/vfx/` | `assets/source/art/` | Keep pickup/hit/success effects readable. |
| SFX | WAV/OGG | `assets/runtime/audio/sfx/` | `assets/source/audio/` | WAV for short repeated SFX; mono when possible. |
| Music/ambience | OGG/MP3 | `assets/runtime/audio/music/`, `assets/runtime/audio/ambience/` | `assets/source/audio/` | OGG for loops/music; use buses for effects. |

## Minimum First-Playable Assets

| Asset | Status | Owner |
| --- | --- | --- |
| Player readable sprite/shape | Placeholder | Art Director |
| Objective/pickup readable sprite/shape | Placeholder | Art Director |
| Goal/exit readable sprite/shape | Placeholder | Art Director |
| HUD text/icons | Placeholder | UI/UX Lead |
| Pickup SFX | Missing | Audio Director |
| Success/failure stinger | Missing | Audio Director |
| Basic VFX feedback | GDQuest shader subset available | Technical Artist |

## License Rule

Do not import non-commercial or unclear-license assets into this template. Record
every third-party source in `docs/specs/asset-list.md` and `docs/third_party/`.

## Content Audit Rule

Before a milestone, release, or open-source publication, use
`docs/studio/content-audit.md` to check runtime paths, source paths, licenses,
placeholder status, `.import` sidecars, and excluded generated folders.
