# Test Plan

## Automated Test Targets

Use the project-local smoke runner for scaffold checks:

```powershell
.\tools\godot\run-tests.ps1
```

The current runner validates:

- `InputBootstrap` creates required actions.
- `GameState.reset_run()` resets score and state.
- `GameState.add_score()` emits score changes.
- `SettingsManager` reads/writes `user://settings.cfg` with safe defaults.
- Required scenes load and instantiate.
- GDQuest shader subset resources load under Godot 4.7.
- The sample first-playable flow runs through AppShell start, pickup, HUD update, goal completion, result visibility, and the public restart button signal.

Add focused checks under `tests/` as production gameplay systems replace the
placeholder loop. Keep deterministic rules in automated checks and leave
subjective feel/readability checks to `playtest-plan.md`.

## Static Checks

Run from project root:

```powershell
rg -n "Godot 4[.]6|res://scene[s]|res://script[s]|emit_signal[(]|[.]instance[(]|yield[(]" .
rg --glob "*.gd" -n "emit_signal[(]|connect[(][\"]|[.]instance[(]|yield[(]"
```

## Godot CLI Checks

Run from the project root:

```powershell
C:\Godot\Godot_v4.7-stable_win64_console.exe --version
.\tools\godot\run-tests.ps1
.\tools\godot\headless-check.ps1
```

If the host PowerShell execution policy blocks local scripts, use a process-only
override such as:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\godot\run-tests.ps1
```

Export smoke check:

```powershell
.\tools\godot\export-smoke.ps1 -Preset "Windows Desktop"
.\tools\godot\export-smoke.ps1 -Preset "Web"
.\tools\godot\export-smoke.ps1 -Preset "Linux"
```

`headless-check.ps1` and `export-smoke.ps1` use isolated project-local Godot
user data. The export smoke then copies matching templates from
`%APPDATA%\Godot\export_templates\<version>\` when they exist. For a portable
CI cache, pass a version folder or template root:

```powershell
.\tools\godot\export-smoke.ps1 -Preset "Windows Desktop" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
.\tools\godot\export-smoke.ps1 -Preset "Web" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
.\tools\godot\export-smoke.ps1 -Preset "Linux" -ExportTemplatesRoot "<path-to-godot-export-templates>\4.7.stable"
```

If Godot 4.7 stable export templates are missing, the script exits before
running export and reports the missing template names.

## Manual Test Coverage

- First playable loop.
- HUD updates.
- Scene reload/restart.
- Main menu, options, pause, result, and debug overlay.
- Settings persistence for audio, fullscreen/window mode, and debug overlay.
- Exported build launch.

## Known Test Gaps

- The integration runner uses deterministic scene signals; physical keyboard, controller, and browser input still need manual/device coverage.
- Export smoke requires matching Godot `4.7.stable` templates for the selected preset on the host
  or in a supplied template cache.
- Placeholder polygon visuals do not validate final asset import behavior.

## Continuous Delivery Coverage

GitHub Actions downloads the pinned official Godot 4.7 stable editor and export-template archives, verifies both against the official SHA512 manifest, runs the SceneTree runner and headless project load, then exports Windows Desktop, Linux, and Web artifacts. Web artifact creation proves packaging only; browser runtime checks remain manual or project-specific automation.
