extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var master_mute: CheckBox = %MasterMute
@onready var music_mute: CheckBox = %MusicMute
@onready var sfx_mute: CheckBox = %SfxMute
@onready var debug_toggle: CheckBox = %DebugToggle
@onready var fullscreen_toggle: CheckBox = %FullscreenToggle

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)
	_refresh_from_settings()
	SignalBus.settings_changed.connect(_refresh_from_settings)

func _refresh_from_settings() -> void:
	master_slider.set_value_no_signal(SettingsManager.master_volume)
	music_slider.set_value_no_signal(SettingsManager.music_volume)
	sfx_slider.set_value_no_signal(SettingsManager.sfx_volume)
	master_mute.set_pressed_no_signal(SettingsManager.master_muted)
	music_mute.set_pressed_no_signal(SettingsManager.music_muted)
	sfx_mute.set_pressed_no_signal(SettingsManager.sfx_muted)
	debug_toggle.set_pressed_no_signal(SettingsManager.debug_overlay_enabled)
	fullscreen_toggle.set_pressed_no_signal(SettingsManager.window_mode == Window.Mode.MODE_FULLSCREEN)

func _on_master_slider_value_changed(value: float) -> void:
	SettingsManager.set_master_volume(value)

func _on_music_slider_value_changed(value: float) -> void:
	SettingsManager.set_music_volume(value)

func _on_sfx_slider_value_changed(value: float) -> void:
	SettingsManager.set_sfx_volume(value)

func _on_master_mute_toggled(button_pressed: bool) -> void:
	SettingsManager.set_master_muted(button_pressed)

func _on_music_mute_toggled(button_pressed: bool) -> void:
	SettingsManager.set_music_muted(button_pressed)

func _on_sfx_mute_toggled(button_pressed: bool) -> void:
	SettingsManager.set_sfx_muted(button_pressed)

func _on_debug_toggle_toggled(button_pressed: bool) -> void:
	SettingsManager.set_debug_overlay_enabled(button_pressed)

func _on_fullscreen_toggle_toggled(button_pressed: bool) -> void:
	SettingsManager.set_window_fullscreen(button_pressed)

func _on_back_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
