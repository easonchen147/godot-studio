param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$ProjectName = "Game",
    [ValidateSet("godot", "unity", "unreal", "unknown")]
    [string]$Engine = "godot",
    [string]$Genre = "custom",
    [string]$TargetPlatform = "desktop",
    [string]$Perspective = "2D",
    [string]$ArtStyle = "clear readable prototype art",
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$script:Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-TextFile {
    param(
        [string]$Path,
        [string]$Value,
        [switch]$Force
    )
    if ((Test-Path -LiteralPath $Path) -and -not $Force) {
        Write-Host "Exists, skipped: $Path"
        return
    }
    [System.IO.File]::WriteAllText($Path, $Value, $script:Utf8NoBom)
    Write-Host "Wrote: $Path"
}

$resolvedProject = (Resolve-Path -LiteralPath $ProjectPath).ProviderPath
$docsDir = Join-Path $resolvedProject "docs"
if (-not (Test-Path -LiteralPath $docsDir)) {
    New-Item -ItemType Directory -Path $docsDir | Out-Null
}

$date = Get-Date -Format "yyyy-MM-dd"

Write-TextFile -Path (Join-Path $docsDir "game-brief.md") -Force:$Force -Value @"
# Game Brief

Generated: $date

## Concept
- Title: $ProjectName
- Engine: $Engine
- Genre: $Genre
- Target platform: $TargetPlatform
- Perspective: $Perspective
- One-sentence pitch: A small first-playable $Engine prototype with a clear core loop.
- Player fantasy: The player should understand the goal quickly and feel responsive control plus visible feedback.

## First Playable
- Goal: Build a 1 to 3 minute playable loop.
- Core loop: Start -> act -> receive feedback -> face obstacle -> succeed/fail -> restart or continue.
- Success state: Visible reward, score, win screen, next-level prompt, or completion feedback.
- Failure state: Clear damage, loss, reset, game over, or retry flow.
- Expected session length: 1 to 3 minutes.

## Controls
- Keyboard/mouse: Define movement and primary action before implementation.
- Gamepad: Add if targeting desktop/controller.
- Touch: Add if targeting mobile.

## Art And Audio
- Visual style: $ArtStyle
- Palette: High contrast for gameplay-critical objects.
- UI style: Simple, readable HUD with only loop-critical information.
- Audio mood: Placeholder SFX for actions, feedback, UI, success, and failure.

## Constraints
- Must-have: Runnable entry scene or level, one core verb, one goal, one obstacle, one success or failure state.
- Out of scope: Large content sets, save systems, shops, complex progression, online features.
- Risks: Scope creep, unclear feedback, missing assets, weak first-time-player readability.
"@

Write-TextFile -Path (Join-Path $docsDir "dev-plan.md") -Force:$Force -Value @"
# Development Plan

## Milestone 1: First Playable
- Create or verify the entry scene or level.
- Add player-controlled core verb.
- Add one interactive object, enemy, hazard, puzzle piece, or decision.
- Add success and failure or retry state.
- Add HUD for current objective and state.
- Run project and inspect logs.

## Milestone 2: Game Feel Pass
- Tune input response.
- Add feedback for movement, action, reward, damage/failure, and success.
- Tune camera framing.
- Add placeholder SFX.
- Run first-time-player test.

## Milestone 3: Art Direction Pass
- Generate or import core runtime assets.
- Replace confusing placeholders.
- Add UI states and icons.
- Verify imported assets and missing references.

## Verification
- Engine: $Engine
- The selected engine's entry scene or level launches when tooling is available.
- Unity projects have no new compile errors or missing scripts when Unity is available.
- Unreal projects have valid project structure and compile-aware Blueprint/C++ checks when Unreal is available.
- No new parse/compile errors or missing resources are introduced.
- Core loop can be completed.
- First-time-player questions in `polish-checklist.md` have clear answers.
"@

Write-TextFile -Path (Join-Path $docsDir "asset-list.md") -Force:$Force -Value @"
# Asset List

## Runtime Sprites And Textures
| Asset | Path | Status | Notes |
| --- | --- | --- | --- |
| Player | assets/sprites/player.png | needed | Must be readable at gameplay scale. |
| Primary obstacle or enemy | assets/sprites/obstacle_or_enemy.png | needed | Distinct from player and background. |
| Reward or goal | assets/sprites/reward_or_goal.png | needed | High contrast, visible from first screen. |

## UI
| Asset | Path | Status | Notes |
| --- | --- | --- | --- |
| Health/status icon | assets/ui/status_icon.png | optional | Add when loop needs persistent state. |
| Button states | assets/ui/button_states.png | optional | Needed for menus. |

## VFX
| Asset | Path | Status | Notes |
| --- | --- | --- | --- |
| Hit or action effect | assets/vfx/action_feedback.png | needed | Feedback for core verb. |
| Success effect | assets/vfx/success_feedback.png | optional | Reward moment. |

## Audio
| Asset | Path | Status | Notes |
| --- | --- | --- | --- |
| Primary action SFX | audio/sfx/action.wav | needed | Placeholder is acceptable. |
| Reward SFX | audio/sfx/reward.wav | needed | Confirms positive feedback. |
| Failure SFX | audio/sfx/failure.wav | optional | Needed if there is a fail state. |
"@

Write-TextFile -Path (Join-Path $docsDir "polish-checklist.md") -Force:$Force -Value @"
# Polish Checklist

## First-Time-Player Test
- What does the player see first?
- What does the player think they should do?
- What input do they try first?
- What feedback confirms the input worked?
- What obstacle, choice, or tension appears?
- How does the loop reward, fail, or restart?

## Game Feel
- Movement or primary action is responsive.
- Core actions have visual feedback.
- Core actions have audio or UI feedback.
- Camera frames the player and next useful target.
- Failure and success are understandable without logs.

## UI
- HUD shows only useful loop information.
- Text fits at 1280x720 and smaller fallback sizes.
- Buttons have default, hover, pressed, and disabled states when menus exist.

## Technical
- Entry scene or level launches.
- No new parse errors.
- No missing resources.
- No broken node paths.
- Imported art is referenced from project folders, not temporary generation folders.
"@

Write-Host "Game docs ready in $docsDir"
