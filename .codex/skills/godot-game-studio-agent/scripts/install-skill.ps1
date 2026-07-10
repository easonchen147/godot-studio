param(
    [string]$SkillSource = "",
    [string]$TargetRoot = "",
    [switch]$Force
)

$ErrorActionPreference = "Stop"

if (-not $SkillSource) {
    $SkillSource = Split-Path -Parent $PSScriptRoot
}

if (-not $TargetRoot) {
    if ($env:CODEX_HOME) {
        $TargetRoot = Join-Path $env:CODEX_HOME "skills"
    } else {
        $TargetRoot = Join-Path $env:USERPROFILE ".codex\skills"
    }
}

$resolvedSource = (Resolve-Path -LiteralPath $SkillSource).ProviderPath
$target = Join-Path $TargetRoot "godot-game-studio-agent"

if ((Test-Path -LiteralPath $target) -and -not $Force) {
    throw "Target skill already exists at $target. Rerun with -Force to replace it."
}

if (-not (Test-Path -LiteralPath $TargetRoot)) {
    New-Item -ItemType Directory -Path $TargetRoot | Out-Null
}

if (Test-Path -LiteralPath $target) {
    Remove-Item -LiteralPath $target -Recurse -Force
}

Copy-Item -LiteralPath $resolvedSource -Destination $target -Recurse

$dist = Join-Path $target "dist"
if (Test-Path -LiteralPath $dist) {
    Remove-Item -LiteralPath $dist -Recurse -Force
}

Write-Host "Installed godot-game-studio-agent to $target"
