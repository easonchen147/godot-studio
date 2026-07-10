extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

@onready var title_label: Label = %TitleLabel
@onready var summary_label: Label = %SummaryLabel

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)

func set_result(title: String, summary: String) -> void:
	title_label.text = title
	summary_label.text = summary

func _on_restart_pressed() -> void:
	SignalBus.restart_run_requested.emit()

func _on_menu_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
