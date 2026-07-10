extends RefCounted
class_name UIThemeHelper

const STUDIO_THEME: Theme = preload("res://shared/resources/studio_ui_theme.tres")

static func apply_theme(control: Control) -> void:
	control.theme = STUDIO_THEME
