param(
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = "Continue"

try {
    $resolvedProject = (Resolve-Path -LiteralPath $ProjectPath -ErrorAction Stop).ProviderPath
} catch {
    Write-Output "unknown"
    exit 0
}

if (Test-Path -LiteralPath (Join-Path $resolvedProject "project.godot")) {
    Write-Output "godot"
    exit 0
}

$unityScore = 0
if (Test-Path -LiteralPath (Join-Path $resolvedProject "Assets")) { $unityScore++ }
if (Test-Path -LiteralPath (Join-Path $resolvedProject "Packages\manifest.json")) { $unityScore++ }
if (Test-Path -LiteralPath (Join-Path $resolvedProject "ProjectSettings\ProjectVersion.txt")) { $unityScore++ }
if ($unityScore -ge 2) {
    Write-Output "unity"
    exit 0
}

$uproject = Get-ChildItem -LiteralPath $resolvedProject -Filter "*.uproject" -File -ErrorAction SilentlyContinue | Select-Object -First 1
if ($uproject) {
    Write-Output "unreal"
    exit 0
}

Write-Output "unknown"
