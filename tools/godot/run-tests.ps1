param(
  [string]$GodotExe = "C:\Godot\Godot_v4.7-stable_win64_console.exe",
  [string]$ProjectPath = "",
  [string]$UserDataRoot = ""
)

$ErrorActionPreference = "Stop"

if ($ProjectPath -eq "") {
  $ProjectPath = Resolve-Path (Join-Path $PSScriptRoot "..\..")
} else {
  $ProjectPath = Resolve-Path $ProjectPath
}

if ($UserDataRoot -eq "") {
  $UserDataRoot = Join-Path $ProjectPath ".tmp-godot-user"
}

$appData = Join-Path $UserDataRoot "appdata"
$localAppData = Join-Path $UserDataRoot "localappdata"
New-Item -ItemType Directory -Force -Path $appData, $localAppData | Out-Null

$env:APPDATA = (Resolve-Path $appData).Path
$env:LOCALAPPDATA = (Resolve-Path $localAppData).Path

Write-Host "[godot-tests] Project: $ProjectPath"
Write-Host "[godot-tests] Godot: $GodotExe"

& $GodotExe --headless --path $ProjectPath --script "res://tests/test_runner.gd"
exit $LASTEXITCODE
