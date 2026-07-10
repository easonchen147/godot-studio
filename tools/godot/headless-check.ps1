param(
  [string]$GodotExe = "C:\Godot\Godot_v4.7-stable_win64_console.exe",
  [string]$ProjectPath = "",
  [string]$UserDataRoot = ""
)

$ErrorActionPreference = "Stop"

function Stop-GodotHeadless {
  param(
    [string]$Message,
    [int]$ExitCode = 1
  )

  [Console]::Error.WriteLine($Message)
  exit $ExitCode
}

if (-not (Test-Path -LiteralPath $GodotExe)) {
  Stop-GodotHeadless -Message "[godot-headless] Godot executable not found: $GodotExe" -ExitCode 1
}

if ($ProjectPath -eq "") {
  $ProjectPath = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")).Path
} else {
  $ProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path
}

if ($UserDataRoot -eq "") {
  $UserDataRoot = Join-Path $ProjectPath ".tmp-godot-user"
}

$appData = Join-Path $UserDataRoot "appdata"
$localAppData = Join-Path $UserDataRoot "localappdata"
New-Item -ItemType Directory -Force -Path $appData, $localAppData | Out-Null

$env:APPDATA = (Resolve-Path -LiteralPath $appData).Path
$env:LOCALAPPDATA = (Resolve-Path -LiteralPath $localAppData).Path

Write-Host "[godot-headless] Project: $ProjectPath"
Write-Host "[godot-headless] Godot: $GodotExe"
Write-Host "[godot-headless] User data: $UserDataRoot"

& $GodotExe --headless --path $ProjectPath --quit
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
  Stop-GodotHeadless -Message "[godot-headless] Headless project load failed with exit code $exitCode." -ExitCode $exitCode
}

Write-Host "[godot-headless] PASS: project loads in headless mode"
exit 0
