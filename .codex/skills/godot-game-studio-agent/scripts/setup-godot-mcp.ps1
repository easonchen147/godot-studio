param(
    [string]$ProjectPath = (Get-Location).Path,
    [string]$CodexConfig = "",
    [switch]$InstallGodotIQ,
    [switch]$InstallAddon,
    [switch]$ReplaceExisting,
    [switch]$NoBackup
)

$ErrorActionPreference = "Stop"

$script:Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Write-TextFile {
    param(
        [string]$Path,
        [string]$Value
    )
    [System.IO.File]::WriteAllText($Path, $Value, $script:Utf8NoBom)
}

function Resolve-CodexConfigPath {
    param([string]$Path)
    if ($Path) { return $Path }
    if ($env:CODEX_HOME) { return (Join-Path $env:CODEX_HOME "config.toml") }
    return (Join-Path $env:USERPROFILE ".codex\config.toml")
}

function ConvertTo-TomlString {
    param([string]$Value)
    $escaped = $Value.Replace('\', '\\').Replace('"', '\"')
    return '"' + $escaped + '"'
}

$resolvedProject = (Resolve-Path -LiteralPath $ProjectPath).ProviderPath
$projectFile = Join-Path $resolvedProject "project.godot"
if (-not (Test-Path -LiteralPath $projectFile)) {
    throw "No project.godot found at $projectFile. Run new-godot-project.ps1 first or pass an existing Godot project path."
}

$uvx = Get-Command "uvx" -ErrorAction SilentlyContinue
if (-not $uvx) {
    throw "uvx was not found. Install uv first, then rerun this script."
}

if ($InstallGodotIQ) {
    $env:PYTHONUTF8 = "1"
    & $uvx.Source godotiq --help | Out-Null
}

if ($InstallAddon) {
    $env:PYTHONUTF8 = "1"
    & $uvx.Source godotiq install-addon $resolvedProject
}

$resolvedCodexConfig = Resolve-CodexConfigPath -Path $CodexConfig
$configDir = Split-Path -Parent $resolvedCodexConfig
if (-not (Test-Path -LiteralPath $configDir)) {
    New-Item -ItemType Directory -Path $configDir | Out-Null
}

$existing = ""
if (Test-Path -LiteralPath $resolvedCodexConfig) {
    $existing = Get-Content -LiteralPath $resolvedCodexConfig -Raw
    if (-not $NoBackup) {
        $backup = "$resolvedCodexConfig.bak-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Copy-Item -LiteralPath $resolvedCodexConfig -Destination $backup
        Write-Host "Backup written: $backup"
    }
}

$projectToml = ConvertTo-TomlString $resolvedProject
$block = @"

# BEGIN managed by godot-game-studio-agent
[mcp_servers.godotiq]
command = "uvx"
args = ["godotiq"]

[mcp_servers.godotiq.env]
GODOTIQ_PROJECT_ROOT = $projectToml
# END managed by godot-game-studio-agent
"@

$managedPattern = "(?s)\r?\n?# BEGIN managed by godot-game-studio-agent.*?# END managed by godot-game-studio-agent\r?\n?"
if ($existing -match $managedPattern) {
    $updated = [regex]::Replace($existing, $managedPattern, $block + [Environment]::NewLine)
    Write-TextFile -Path $resolvedCodexConfig -Value $updated
    Write-Host "Updated managed GodotIQ MCP server in $resolvedCodexConfig"
} elseif ($existing -match "\[mcp_servers\.godotiq\]" -and -not $ReplaceExisting) {
    Write-Host "Codex config already has [mcp_servers.godotiq]. Rerun with -ReplaceExisting to append a managed replacement block, or edit GODOTIQ_PROJECT_ROOT manually:"
    Write-Host $resolvedProject
} else {
    Write-TextFile -Path $resolvedCodexConfig -Value ($existing.TrimEnd() + $block + [Environment]::NewLine)
    Write-Host "Added GodotIQ MCP server to $resolvedCodexConfig"
}

Write-Host "Restart Codex so the MCP server is loaded."
