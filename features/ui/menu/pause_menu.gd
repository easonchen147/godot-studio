extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)

func _on_resume_pressed() -> void:
	SignalBus.resume_game_requested.emit()

func _on_restart_pressed() -> void:
	SignalBus.restart_run_requested.emit()

func _on_options_pressed() -> void:
	SignalBus.open_options_requested.emit()

func _on_menu_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
