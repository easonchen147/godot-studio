param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$ProjectName = "Godot Game",
    [ValidateSet("godot", "unity", "unreal", "auto")]
    [string]$Engine = "godot",
    [string]$Genre = "custom",
    [string]$TargetPlatform = "desktop",
    [string]$Perspective = "2D",
    [string]$ArtStyle = "clear readable prototype art",
    [switch]$SetupMcp,
    [switch]$InstallGodotIQ,
    [switch]$InstallAddon,
    [switch]$ForceDocs
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ProjectPath)) {
    New-Item -ItemType Directory -Path $ProjectPath | Out-Null
}

$resolvedProject = (Resolve-Path -LiteralPath $ProjectPath).ProviderPath
$projectFile = Join-Path $resolvedProject "project.godot"

$detectedEngine = & (Join-Path $PSScriptRoot "detect-game-engine.ps1") -ProjectPath $resolvedProject
$effectiveEngine = if ($Engine -eq "auto") { $detectedEngine } else { $Engine }

if ($effectiveEngine -eq "unknown") {
    Write-Host "No engine markers found. Starter docs will be created, but no engine project will be generated."
} elseif ($effectiveEngine -eq "godot" -and -not (Test-Path -LiteralPath $projectFile)) {
    & (Join-Path $PSScriptRoot "new-godot-project.ps1") -ProjectPath $resolvedProject -ProjectName $ProjectName
} elseif ($effectiveEngine -eq "godot") {
    Write-Host "Existing Godot project found: $projectFile"
} else {
    Write-Host "$effectiveEngine starter selected. Engine project files are not generated automatically; create/open the project with the official editor tooling."
    foreach ($dirName in @("Assets", "Content", "Source", "Config", "docs", "art", "assets", "audio", "exports", "tests", "tools")) {
        $dir = Join-Path $resolvedProject $dirName
        if (-not (Test-Path -LiteralPath $dir)) {
            New-Item -ItemType Directory -Path $dir | Out-Null
        }
    }
}

& (Join-Path $PSScriptRoot "create-game-docs.ps1") `
    -ProjectPath $resolvedProject `
    -ProjectName $ProjectName `
    -Engine $(if ($effectiveEngine -eq "auto") { "unknown" } else { $effectiveEngine }) `
    -Genre $Genre `
    -TargetPlatform $TargetPlatform `
    -Perspective $Perspective `
    -ArtStyle $ArtStyle `
    -Force:$ForceDocs

if ($SetupMcp) {
    if ($effectiveEngine -eq "godot") {
        & (Join-Path $PSScriptRoot "setup-godot-mcp.ps1") `
            -ProjectPath $resolvedProject `
            -InstallGodotIQ:$InstallGodotIQ `
            -InstallAddon:$InstallAddon
    } else {
        Write-Host "MCP auto-setup is currently available only for Godot/GodotIQ in this skill."
    }
}

Write-Host "Game project bootstrap complete: $resolvedProject"
