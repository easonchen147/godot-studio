extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)

func _on_back_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
