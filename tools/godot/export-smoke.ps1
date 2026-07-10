param(
  [string]$GodotExe = "C:\Godot\Godot_v4.7-stable_win64_console.exe",
  [string]$ProjectPath = "",
  [string]$Preset = "Windows Desktop",
  [string]$OutputPath = "",
  [string]$UserDataRoot = "",
  [string]$ExportTemplatesRoot = ""
)

$ErrorActionPreference = "Stop"

function Stop-GodotExport {
  param(
    [string]$Message,
    [int]$ExitCode = 1
  )

  [Console]::Error.WriteLine($Message)
  exit $ExitCode
}

function Get-GodotVersionInfo {
  param([string]$GodotExePath)

  if (-not (Test-Path -LiteralPath $GodotExePath)) {
    Stop-GodotExport -Message "[godot-export] Godot executable not found: $GodotExePath" -ExitCode 1
  }

  $versionOutput = & $GodotExePath --version
  if ($LASTEXITCODE -ne 0) {
    Stop-GodotExport -Message "[godot-export] Failed to read Godot version from: $GodotExePath" -ExitCode 1
  }

  $versionLine = (($versionOutput | Select-Object -First 1) -as [string]).Trim()
  $parts = $versionLine.Split(".")
  if ($parts.Length -lt 3) {
    Stop-GodotExport -Message "[godot-export] Unexpected Godot version output: $versionLine" -ExitCode 1
  }

  return @{
    Full = $versionLine
    TemplateVersion = "$($parts[0]).$($parts[1]).$($parts[2])"
  }
}

function Get-GodotExportTarget {
  param([string]$PresetName)

  switch ($PresetName) {
    "Windows Desktop" {
      return @{
        DefaultOutput = "build\windows\godot-studio-starter.exe"
        RequiredTemplates = @("windows_release_x86_64.exe")
      }
    }
    "Linux" {
      return @{
        DefaultOutput = "build\linux\godot-studio-starter.x86_64"
        RequiredTemplates = @("linux_release.x86_64")
      }
    }
    "Web" {
      return @{
        DefaultOutput = "build\web\index.html"
        RequiredTemplates = @("web_release.zip")
      }
    }
    default {
      Stop-GodotExport -Message "[godot-export] Unsupported preset '$PresetName'. Supported presets: Windows Desktop, Linux, Web." -ExitCode 1
    }
  }
}

function Resolve-TemplateDirectory {
  param(
    [string]$Root,
    [string]$TemplateVersion,
    [string[]]$RequiredTemplates
  )

  if ([string]::IsNullOrWhiteSpace($Root) -or -not (Test-Path -LiteralPath $Root)) {
    return $null
  }

  $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
  $candidatePaths = @($resolvedRoot, (Join-Path $resolvedRoot $TemplateVersion))
  foreach ($candidatePath in $candidatePaths) {
    if (-not (Test-Path -LiteralPath $candidatePath)) {
      continue
    }

    $missingTemplates = @($RequiredTemplates | Where-Object {
      -not (Test-Path -LiteralPath (Join-Path $candidatePath $_))
    })
    if ($missingTemplates.Count -eq 0) {
      return (Resolve-Path -LiteralPath $candidatePath).Path
    }
  }

  return $null
}

if ($ProjectPath -eq "") {
  $ProjectPath = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\..")).Path
} else {
  $ProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path
}

$target = Get-GodotExportTarget -PresetName $Preset
if ($OutputPath -eq "") {
  $OutputPath = Join-Path $ProjectPath $target.DefaultOutput
} elseif (-not [System.IO.Path]::IsPathRooted($OutputPath)) {
  $OutputPath = Join-Path $ProjectPath $OutputPath
}

if ($UserDataRoot -eq "") {
  $UserDataRoot = Join-Path $ProjectPath ".tmp-godot-user"
}

$versionInfo = Get-GodotVersionInfo -GodotExePath $GodotExe
$templateVersion = [string]$versionInfo.TemplateVersion
$requiredTemplates = @($target.RequiredTemplates)

$presetConfigPath = Join-Path $ProjectPath "export_presets.cfg"
if (-not (Test-Path -LiteralPath $presetConfigPath)) {
  Stop-GodotExport -Message "[godot-export] Missing export_presets.cfg in project: $ProjectPath" -ExitCode 1
}

$presetConfig = Get-Content -LiteralPath $presetConfigPath -Raw
if ($presetConfig -notmatch ('name="' + [regex]::Escape($Preset) + '"')) {
  Stop-GodotExport -Message "[godot-export] Preset '$Preset' was not found in export_presets.cfg." -ExitCode 1
}

$outputDir = Split-Path -Parent $OutputPath
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

$appData = Join-Path $UserDataRoot "appdata"
$localAppData = Join-Path $UserDataRoot "localappdata"
New-Item -ItemType Directory -Force -Path $appData, $localAppData | Out-Null

$hostTemplatesRoot = Join-Path ([Environment]::GetFolderPath("ApplicationData")) "Godot\export_templates"
$searchedTemplatesRoot = $hostTemplatesRoot
if ($ExportTemplatesRoot -ne "") {
  $searchedTemplatesRoot = $ExportTemplatesRoot
}

$templateSourceDir = Resolve-TemplateDirectory -Root $searchedTemplatesRoot -TemplateVersion $templateVersion -RequiredTemplates $requiredTemplates
if ($ExportTemplatesRoot -ne "" -and $templateSourceDir -eq $null) {
  Stop-GodotExport -Message "[godot-export] Missing Godot export templates. Preset: $Preset. Version: $templateVersion. Expected files: $($requiredTemplates -join ', '). Searched root: $searchedTemplatesRoot." -ExitCode 2
}

$templateTargetDir = Join-Path $appData "Godot\export_templates\$templateVersion"
if ($templateSourceDir -ne $null) {
  New-Item -ItemType Directory -Force -Path $templateTargetDir | Out-Null
  foreach ($templateName in $requiredTemplates) {
    Copy-Item -LiteralPath (Join-Path $templateSourceDir $templateName) -Destination $templateTargetDir -Force
  }

  $versionFile = Join-Path $templateSourceDir "version.txt"
  if (Test-Path -LiteralPath $versionFile) {
    Copy-Item -LiteralPath $versionFile -Destination $templateTargetDir -Force
  }
}

$missingTemplates = @($requiredTemplates | Where-Object {
  -not (Test-Path -LiteralPath (Join-Path $templateTargetDir $_))
})
if ($missingTemplates.Count -gt 0) {
  Stop-GodotExport -Message "[godot-export] Missing Godot export templates. Preset: $Preset. Version: $templateVersion. Expected files: $($requiredTemplates -join ', '). Missing files: $($missingTemplates -join ', '). Searched root: $searchedTemplatesRoot. Isolated cache: $templateTargetDir." -ExitCode 2
}

$env:APPDATA = (Resolve-Path -LiteralPath $appData).Path
$env:LOCALAPPDATA = (Resolve-Path -LiteralPath $localAppData).Path

Write-Host "[godot-export] Project: $ProjectPath"
Write-Host "[godot-export] Godot: $($versionInfo.Full)"
Write-Host "[godot-export] Preset: $Preset"
Write-Host "[godot-export] Output: $OutputPath"
Write-Host "[godot-export] Templates: $templateTargetDir"

& $GodotExe --headless --path $ProjectPath --export-release $Preset $OutputPath
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
  Stop-GodotExport -Message "[godot-export] Export command failed with exit code $exitCode. Check whether matching Godot $templateVersion export templates are installed." -ExitCode $exitCode
}

if (-not (Test-Path -LiteralPath $OutputPath)) {
  Stop-GodotExport -Message "[godot-export] Export command succeeded but output file was not created: $OutputPath" -ExitCode 1
}

$item = Get-Item -LiteralPath $OutputPath
if ($item.Length -le 0) {
  Stop-GodotExport -Message "[godot-export] Output file is empty: $OutputPath" -ExitCode 1
}

Write-Host "[godot-export] PASS: created $($item.FullName) ($($item.Length) bytes)"
exit 0