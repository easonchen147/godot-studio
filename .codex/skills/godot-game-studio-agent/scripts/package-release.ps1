param(
    [string]$SkillRoot = "",
    [string]$OutputDir = "",
    [string]$Version = (Get-Date -Format "yyyyMMdd-HHmmss")
)

$ErrorActionPreference = "Stop"

if (-not $SkillRoot) {
    $SkillRoot = Split-Path -Parent $PSScriptRoot
}

$resolvedSkillRoot = (Resolve-Path -LiteralPath $SkillRoot).ProviderPath
if (-not $OutputDir) {
    $OutputDir = Join-Path $resolvedSkillRoot "dist"
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$packageRoot = Join-Path $OutputDir "godot-game-studio-agent-$Version"
if (Test-Path -LiteralPath $packageRoot) {
    Remove-Item -LiteralPath $packageRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $packageRoot | Out-Null

Get-ChildItem -LiteralPath $resolvedSkillRoot -Force |
    Where-Object { $_.Name -ne "dist" } |
    ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $packageRoot -Recurse
    }

$zip = "$packageRoot.zip"
if (Test-Path -LiteralPath $zip) {
    Remove-Item -LiteralPath $zip -Force
}

Compress-Archive -Path (Join-Path $packageRoot "*") -DestinationPath $zip
Remove-Item -LiteralPath $packageRoot -Recurse -Force
Write-Host "Release package: $zip"
