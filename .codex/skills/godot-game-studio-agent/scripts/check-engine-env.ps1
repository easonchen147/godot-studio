param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$GodotPath = "",
    [string]$UnityPath = "",
    [string]$UnrealPath = ""
)

$ErrorActionPreference = "Continue"

function Test-CommandAvailable {
    param([string]$Name)
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    return $null
}

function Write-Check {
    param([string]$Name, [bool]$Ok, [string]$Detail)
    $status = if ($Ok) { "OK" } else { "WARN" }
    "{0,-6} {1,-28} {2}" -f $status, $Name, $Detail
}

$engine = & (Join-Path $PSScriptRoot "detect-game-engine.ps1") -ProjectPath $ProjectPath

try {
    $resolvedProject = (Resolve-Path -LiteralPath $ProjectPath -ErrorAction Stop).ProviderPath
} catch {
    $resolvedProject = $ProjectPath
}

Write-Host "Game Studio Agent engine environment check"
Write-Host "Project: $resolvedProject"
Write-Host "Detected engine: $engine"
Write-Host ""

Write-Check "engine marker" ($engine -ne "unknown") $engine

$godot = $GodotPath
if (-not $godot -and $env:GODOT4_PATH) { $godot = $env:GODOT4_PATH }
if (-not $godot -and $env:GODOT_PATH) { $godot = $env:GODOT_PATH }
if (-not $godot) { $godot = Test-CommandAvailable "godot4" }
if (-not $godot) { $godot = Test-CommandAvailable "godot" }
Write-Check "Godot executable" ($godot -and (Test-Path -LiteralPath $godot)) "$godot"

$unity = $UnityPath
if (-not $unity -and $env:UNITY_EDITOR_PATH) { $unity = $env:UNITY_EDITOR_PATH }
if (-not $unity) { $unity = Test-CommandAvailable "Unity" }
if (-not $unity) { $unity = Test-CommandAvailable "Unity.exe" }
Write-Check "Unity editor" ($unity -and (Test-Path -LiteralPath $unity)) "$unity"

$unreal = $UnrealPath
if (-not $unreal -and $env:UNREAL_EDITOR_PATH) { $unreal = $env:UNREAL_EDITOR_PATH }
if (-not $unreal -and $env:UE_EDITOR_PATH) { $unreal = $env:UE_EDITOR_PATH }
if (-not $unreal) { $unreal = Test-CommandAvailable "UnrealEditor-Cmd" }
if (-not $unreal) { $unreal = Test-CommandAvailable "UnrealEditor" }
Write-Check "Unreal editor" ($unreal -and (Test-Path -LiteralPath $unreal)) "$unreal"

$python = Test-CommandAvailable "python"
Write-Check "python" ($null -ne $python) "$python"

$uvx = Test-CommandAvailable "uvx"
Write-Check "uvx" ($null -ne $uvx) "$uvx"

$node = Test-CommandAvailable "node"
Write-Check "node" ($null -ne $node) "$node"

$git = Test-CommandAvailable "git"
Write-Check "git" ($null -ne $git) "$git"

if ($engine -eq "unity") {
    Write-Check "Unity manifest" (Test-Path -LiteralPath (Join-Path $resolvedProject "Packages\manifest.json")) "Packages\manifest.json"
    Write-Check "Unity version file" (Test-Path -LiteralPath (Join-Path $resolvedProject "ProjectSettings\ProjectVersion.txt")) "ProjectSettings\ProjectVersion.txt"
}

if ($engine -eq "unreal") {
    $uproject = Get-ChildItem -LiteralPath $resolvedProject -Filter "*.uproject" -File -ErrorAction SilentlyContinue | Select-Object -First 1
    Write-Check "Unreal project" ($null -ne $uproject) "$($uproject.FullName)"
}

if ($engine -eq "unknown") {
    Write-Host "No engine project markers were found. Choose -Engine godot, unity, or unreal when bootstrapping starter docs."
}
