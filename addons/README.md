# Addons Policy

This template intentionally ships without mandatory Godot editor plugins.

Keep the base project small, MIT-friendly, and runnable with vanilla Godot
4.7. Add plugins only when a specific game needs them, then document the
decision in `docs/third_party/plugin-catalog.md` and keep each plugin under
`addons/<plugin_name>/`.

Before adding a plugin:

1. Confirm Godot 4.7 compatibility.
2. Confirm license compatibility with the target game.
3. Prefer MIT or similarly permissive licenses for open-source templates.
4. Add a third-party notice under `docs/third_party/` if code is imported.
5. Run `tools/godot/run-tests.ps1` after enabling the plugin.
