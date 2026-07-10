extends Node

const SETTINGS_PATH: String = "user://settings.cfg"
const WINDOW_PATH: String = "user://window.cfg"
const DEFAULT_WINDOW_SIZE: Vector2i = Vector2i(1280, 720)
const DEFAULT_WINDOW_POSITION: Vector2i = Vector2i(80, 80)

var master_volume: float = 1.0
var music_volume: float = 0.7
var sfx_volume: float = 0.85
var ui_volume: float = 0.85
var ambience_volume: float = 0.7

var master_muted: bool = false
var music_muted: bool = false
var sfx_muted: bool = false
var ui_muted: bool = false
var ambience_muted: bool = false

var current_theme: StringName = &"default"
var transition_duration: float = 0.15
var debug_overlay_enabled: bool = false

var window_mode: int = Window.Mode.MODE_WINDOWED
var window_position: Vector2i = DEFAULT_WINDOW_POSITION
var window_size: Vector2i = DEFAULT_WINDOW_SIZE

func _enter_tree() -> void:
	load_settings()
	load_window_state()
	apply_window_state()

func _ready() -> void:
	SignalBus.settings_loaded.emit()
	SignalBus.settings_changed.emit()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_all()

func _exit_tree() -> void:
	save_all()

func save_all() -> void:
	save_settings()
	save_window_state()

func load_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	var error_code: Error = config.load(SETTINGS_PATH)
	if error_code != OK:
		return

	master_volume = clampf(float(config.get_value("audio", "master_volume", master_volume)), 0.0, 1.0)
	music_volume = clampf(float(config.get_value("audio", "music_volume", music_volume)), 0.0, 1.0)
	sfx_volume = clampf(float(config.get_value("audio", "sfx_volume", sfx_volume)), 0.0, 1.0)
	ui_volume = clampf(float(config.get_value("audio", "ui_volume", ui_volume)), 0.0, 1.0)
	ambience_volume = clampf(float(config.get_value("audio", "ambience_volume", ambience_volume)), 0.0, 1.0)

	master_muted = bool(config.get_value("audio", "master_muted", master_muted))
	music_muted = bool(config.get_value("audio", "music_muted", music_muted))
	sfx_muted = bool(config.get_value("audio", "sfx_muted", sfx_muted))
	ui_muted = bool(config.get_value("audio", "ui_muted", ui_muted))
	ambience_muted = bool(config.get_value("audio", "ambience_muted", ambience_muted))

	current_theme = StringName(config.get_value("ui", "theme", String(current_theme)))
	transition_duration = clampf(float(config.get_value("ui", "transition_duration", transition_duration)), 0.0, 2.0)
	debug_overlay_enabled = bool(config.get_value("ui", "debug_overlay_enabled", debug_overlay_enabled))

func save_settings() -> void:
	var config: ConfigFile = ConfigFile.new()
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("audio", "ui_volume", ui_volume)
	config.set_value("audio", "ambience_volume", ambience_volume)

	config.set_value("audio", "master_muted", master_muted)
	config.set_value("audio", "music_muted", music_muted)
	config.set_value("audio", "sfx_muted", sfx_muted)
	config.set_value("audio", "ui_muted", ui_muted)
	config.set_value("audio", "ambience_muted", ambience_muted)

	config.set_value("ui", "theme", String(current_theme))
	config.set_value("ui", "transition_duration", transition_duration)
	config.set_value("ui", "debug_overlay_enabled", debug_overlay_enabled)
	config.save(SETTINGS_PATH)

func load_window_state() -> void:
	var config: ConfigFile = ConfigFile.new()
	var error_code: Error = config.load(WINDOW_PATH)
	if error_code != OK:
		return

	window_mode = int(config.get_value("window", "mode", window_mode))
	window_position = config.get_value("window", "position", window_position)
	window_size = config.get_value("window", "size", window_size)

func save_window_state() -> void:
	if Engine.is_embedded_in_editor() or DisplayServer.get_name() == "headless":
		return

	var window: Window = get_window()
	window_mode = int(window.mode)
	window_position = window.position
	window_size = window.size

	var config: ConfigFile = ConfigFile.new()
	config.set_value("window", "mode", window_mode)
	config.set_value("window", "position", window_position)
	config.set_value("window", "size", window_size)
	config.save(WINDOW_PATH)

func apply_window_state() -> void:
	if Engine.is_embedded_in_editor() or DisplayServer.get_name() == "headless":
		return

	var window: Window = get_window()
	window.mode = window_mode
	if window.mode == Window.Mode.MODE_WINDOWED:
		window.position = window_position
		window.size = window_size

func set_master_volume(value: float) -> void:
	master_volume = clampf(value, 0.0, 1.0)
	save_settings()
	SignalBus.settings_changed.emit()

func set_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	save_settings()
	SignalBus.settings_changed.emit()

func set_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)
	save_settings()
	SignalBus.settings_changed.emit()

func set_master_muted(value: bool) -> void:
	master_muted = value
	save_settings()
	SignalBus.settings_changed.emit()

func set_music_muted(value: bool) -> void:
	music_muted = value
	save_settings()
	SignalBus.settings_changed.emit()

func set_sfx_muted(value: bool) -> void:
	sfx_muted = value
	save_settings()
	SignalBus.settings_changed.emit()

func set_debug_overlay_enabled(value: bool) -> void:
	debug_overlay_enabled = value
	save_settings()
	SignalBus.settings_changed.emit()

func set_window_fullscreen(enabled: bool) -> void:
	window_mode = Window.Mode.MODE_FULLSCREEN if enabled else Window.Mode.MODE_WINDOWED
	apply_window_state()
	save_window_state()
	SignalBus.settings_changed.emit()
