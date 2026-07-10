# Open Source Audit

Status: template-ready with one external shader-source dependency documented.

Target license for this template: MIT.

## Findings

| Area | Status | Notes |
| --- | --- | --- |
| Project license | Ready | Root `LICENSE` contains MIT license text for the template. |
| Personal data | Ready | No personal email, API key, token, or credential is required by the scaffold. |
| Company/private names | Ready | No proprietary company name is required by the scaffold. |
| Godot engine | Ready | Godot Engine is referenced as the target editor/runtime, not vendored. |
| GDQuest shaders | Ready with notice | Only MIT shader source files were imported. Upstream CC-BY-NC-SA art/model assets were excluded. Notice: `docs/third_party/gdquest-godot-shaders.md`. |
| Export credentials | Ready | `export_credentials.cfg` is ignored. |
| Local paths | Ready | Example export-template paths use placeholders instead of machine-specific paths. |
| Godot cache and builds | Ready | `.godot/`, `.tmp-godot-user/`, `build/`, and `exports/` are ignored. Generated export binaries are validation artifacts, not source files. |
| Third-party plugins | Ready | No plugin code is installed by default; candidates are documented in `docs/third_party/plugin-catalog.md`. |
| Project-local skills | Ready | Skill files are prompt/docs/scripts only; no binary editor plugin or packaged private component is installed. |

## Red Flags To Avoid Before Publishing

- Do not commit `.godot/`, `.import/`, `build/`, `exports/`, or export credentials.
- Do not commit generated AI images/audio unless their license and prompt source are documented.
- Do not import non-commercial asset packs into the base template.
- Do not paste API keys, account names, local user paths, or private repo URLs into docs.
- Do not enable a plugin without recording source, version, and license.

## Pre-Publish Check

Run from `godot-studio/`:

```powershell
rg -n "CC-BY-NC|NonCommercial|all rights reserved|not for commercial" .
tools\\godot\\run-tests.ps1
```

Also run a dedicated credential scanner and scan for local user-profile paths before
publishing. The license scan may find the GDQuest notice because it intentionally documents
the upstream non-commercial art boundary. That is acceptable as long as no
non-commercial assets are imported.

Final local audit on 2026-07-09 found no real credentials, no personal emails,
no user-profile paths, no private company names, no installed `addons/` plugin
code, and no risky binary/license-bearing assets outside ignored build/cache
outputs.
