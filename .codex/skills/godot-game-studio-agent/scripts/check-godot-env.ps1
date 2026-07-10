param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$GodotPath = "",
    [string]$CodexConfig = "",
    [switch]$ShowGodotPathOnly
)

$ErrorActionPreference = "Continue"

function Test-CommandAvailable {
    param([string]$Name)
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }
    return $null
}

function Resolve-CodexConfigPath {
    param([string]$Path)
    if ($Path) { return $Path }
    if ($env:CODEX_HOME) { return (Join-Path $env:CODEX_HOME "config.toml") }
    return (Join-Path $env:USERPROFILE ".codex\config.toml")
}

function Resolve-GodotExecutable {
    param([string]$Path)

    $candidates = New-Object System.Collections.Generic.List[string]
    if ($Path) { $candidates.Add($Path) }
    if ($env:GODOT4_PATH) { $candidates.Add($env:GODOT4_PATH) }
    if ($env:GODOT_PATH) { $candidates.Add($env:GODOT_PATH) }

    foreach ($commandName in @("godot4", "godot")) {
        $commandPath = Test-CommandAvailable $commandName
        if ($commandPath) { $candidates.Add($commandPath) }
    }

    foreach ($candidate in ($candidates | Select-Object -Unique)) {
        if ($candidate -and (Test-Path -LiteralPath $candidate)) { return $candidate }
    }

    $extraRoots = @()
    if ($env:GODOT_SCAN_ROOTS) {
        $extraRoots = $env:GODOT_SCAN_ROOTS -split [IO.Path]::PathSeparator
    }

    $roots = (@(
        $env:LOCALAPPDATA,
        $env:PROGRAMFILES,
        ${env:ProgramFiles(x86)},
        (Join-Path $env:USERPROFILE "Downloads")
    ) + $extraRoots) | Where-Object { $_ -and (Test-Path -LiteralPath $_) }

    foreach ($root in $roots) {
        try {
            Get-ChildItem -LiteralPath $root -Filter "Godot*_console.exe" -File -Recurse -Depth 3 -ErrorAction SilentlyContinue |
                Sort-Object FullName -Descending |
                ForEach-Object { $candidates.Add($_.FullName) }
            Get-ChildItem -LiteralPath $root -Filter "Godot*.exe" -File -Recurse -Depth 3 -ErrorAction SilentlyContinue |
                Sort-Object FullName -Descending |
                ForEach-Object { $candidates.Add($_.FullName) }
        } catch {
        }
    }

    foreach ($candidate in ($candidates | Select-Object -Unique)) {
        if ($candidate -and (Test-Path -LiteralPath $candidate)) { return $candidate }
    }

    return $null
}

function Write-Check {
    param([string]$Name, [bool]$Ok, [string]$Detail)
    $status = if ($Ok) { "OK" } else { "WARN" }
    "{0,-6} {1,-24} {2}" -f $status, $Name, $Detail
}

$resolvedProject = $null
try {
    $resolvedProject = (Resolve-Path -LiteralPath $ProjectPath -ErrorAction Stop).ProviderPath
} catch {
    $resolvedProject = $ProjectPath
}

$resolvedGodot = Resolve-GodotExecutable -Path $GodotPath
if ($ShowGodotPathOnly) {
    if ($resolvedGodot) {
        Write-Output $resolvedGodot
        exit 0
    }
    Write-Error "Godot executable was not found. Pass -GodotPath or set GODOT4_PATH/GODOT_PATH."
    exit 1
}

$resolvedCodexConfig = Resolve-CodexConfigPath -Path $CodexConfig

Write-Host "Game Studio Agent Godot environment check"
Write-Host "Project: $resolvedProject"
Write-Host ""

$projectFile = Join-Path $resolvedProject "project.godot"
Write-Check "project.godot" (Test-Path -LiteralPath $projectFile) $projectFile

Write-Check "Godot executable" ($null -ne $resolvedGodot) $(if ($resolvedGodot) { $resolvedGodot } else { "Pass -GodotPath or set GODOT4_PATH/GODOT_PATH." })
if ($resolvedGodot) {
    try {
        $version = & $resolvedGodot --version 2>&1
        Write-Check "Godot version" ($LASTEXITCODE -eq 0) ($version -join " ")
    } catch {
        Write-Check "Godot version" $false $_.Exception.Message
    }
}

$python = Test-CommandAvailable "python"
Write-Check "python" ($null -ne $python) "$python"

$uvx = Test-CommandAvailable "uvx"
Write-Check "uvx" ($null -ne $uvx) "$uvx"

$node = Test-CommandAvailable "node"
Write-Check "node" ($null -ne $node) "$node"

$npm = Test-CommandAvailable "npm"
Write-Check "npm" ($null -ne $npm) "$npm"

$git = Test-CommandAvailable "git"
Write-Check "git" ($null -ne $git) "$git"

$configExists = Test-Path -LiteralPath $resolvedCodexConfig
Write-Check "Codex config" $configExists $resolvedCodexConfig
if ($configExists) {
    $config = Get-Content -LiteralPath $resolvedCodexConfig -Raw
    Write-Check "godotiq MCP" ($config -match "\[mcp_servers\.godotiq\]") "config.toml entry"
    Write-Check "project root env" ($config -match [regex]::Escape($resolvedProject)) "GODOTIQ_PROJECT_ROOT"
}

if ($resolvedProject.StartsWith("\\")) {
    Write-Check "UNC workspace" $true "Some cmd.exe-launched tools may need a mapped drive."
}
