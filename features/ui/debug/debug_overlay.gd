extends CanvasLayer

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")

@onready var panel: Control = $Panel
@onready var scene_label: Label = %SceneLabel
@onready var state_label: Label = %StateLabel
@onready var score_label: Label = %ScoreLabel
@onready var settings_label: Label = %SettingsLabel
@onready var message_label: Label = %MessageLabel

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	UI_THEME_HELPER.apply_theme(panel)
	SignalBus.score_changed.connect(_on_score_changed)
	SignalBus.session_state_changed.connect(_on_session_state_changed)
	SignalBus.scene_change_started.connect(_on_scene_change_started)
	SignalBus.scene_changed.connect(_on_scene_changed)
	SignalBus.scene_change_failed.connect(_on_scene_change_failed)
	SignalBus.message_shown.connect(_on_message_shown)
	SignalBus.settings_changed.connect(_refresh)
	_refresh()

func _refresh() -> void:
	scene_label.text = "Scene: %s" % GameState.active_game_scene_path
	state_label.text = "State: %s / %s" % [String(GameState.session_state), GameState.get_run_state_label()]
	score_label.text = "Score: %d" % GameState.score
	settings_label.text = "Audio Mute M/Mu/S: %s/%s/%s  Debug: %s" % [
		str(SettingsManager.master_muted),
		str(SettingsManager.music_muted),
		str(SettingsManager.sfx_muted),
		str(SettingsManager.debug_overlay_enabled)
	]

func _on_score_changed(_new_score: int) -> void:
	_refresh()

func _on_session_state_changed(_session_state: String) -> void:
	_refresh()

func _on_scene_change_started(scene_path: String) -> void:
	message_label.text = "Loading: %s" % scene_path
	_refresh()

func _on_scene_changed(scene_path: String) -> void:
	message_label.text = "Loaded: %s" % scene_path
	_refresh()

func _on_scene_change_failed(scene_path: String, error_code: int) -> void:
	message_label.text = "Load failed: %s (%d)" % [scene_path, error_code]
	_refresh()

func _on_message_shown(message: String) -> void:
	message_label.text = message
	_refresh()

func _on_restart_pressed() -> void:
	SignalBus.restart_run_requested.emit()

func _on_menu_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
