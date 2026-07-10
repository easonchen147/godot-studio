extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

@onready var version_label: Label = %VersionLabel

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)
	var version: String = str(ProjectSettings.get_setting("application/config/version", "0.1.0"))
	version_label.text = "Godot Studio Starter 4.7  v%s" % version

func _on_start_pressed() -> void:
	AudioManager.play_ui_accept()
	SignalBus.start_game_requested.emit()

func _on_options_pressed() -> void:
	AudioManager.play_ui_accept()
	SignalBus.open_options_requested.emit()

func _on_credits_pressed() -> void:
	AudioManager.play_ui_accept()
	SignalBus.open_credits_requested.emit()

func _on_shader_showcase_pressed() -> void:
	AudioManager.play_ui_accept()
	SignalBus.open_shader_showcase_requested.emit()

func _on_quit_pressed() -> void:
	SettingsManager.save_all()
	get_tree().quit()
