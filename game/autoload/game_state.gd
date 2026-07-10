extends Node

const INPUT_BOOTSTRAP_SCRIPT: GDScript = preload("res://shared/utils/input_bootstrap.gd")
const APP_SHELL_SCENE_PATH: String = "res://game/app/app_shell.tscn"
const DEFAULT_GAME_SCENE_PATH: String = "res://game/main/main.tscn"

enum RunState { READY, PLAYING, COMPLETE, FAILED }

var score: int = 0
var run_state: RunState = RunState.READY
var active_game_scene_path: String = DEFAULT_GAME_SCENE_PATH
var boot_started: bool = false
var boot_completed: bool = false
var session_state: StringName = &"menu"

func _ready() -> void:
	INPUT_BOOTSTRAP_SCRIPT.ensure_default_actions()

func mark_boot_started() -> void:
	boot_started = true
	boot_completed = false

func mark_boot_completed() -> void:
	boot_started = true
	boot_completed = true

func set_active_game_scene(scene_path: String) -> void:
	if scene_path.is_empty():
		return
	active_game_scene_path = scene_path

func reset_session() -> void:
	score = 0
	run_state = RunState.READY
	session_state = &"menu"
	SignalBus.score_changed.emit(score)
	SignalBus.session_state_changed.emit(String(session_state))

func reset_run() -> void:
	score = 0
	run_state = RunState.PLAYING
	session_state = &"gameplay"
	SignalBus.score_changed.emit(score)
	SignalBus.session_state_changed.emit(String(session_state))
	SignalBus.run_reset.emit()

func add_score(amount: int) -> void:
	score += amount
	SignalBus.score_changed.emit(score)

func complete_run() -> void:
	run_state = RunState.COMPLETE
	session_state = &"result"
	SignalBus.session_state_changed.emit(String(session_state))
	SignalBus.run_completed.emit()

func reload_active_game_scene() -> void:
	SceneLoader.change_scene(active_game_scene_path)

func fail_run(message: String = "Run failed.") -> void:
	run_state = RunState.FAILED
	session_state = &"result"
	SignalBus.session_state_changed.emit(String(session_state))
	SignalBus.message_shown.emit(message)
	SignalBus.run_failed.emit(message)

func get_run_state_label() -> String:
	match run_state:
		RunState.READY:
			return "ready"
		RunState.PLAYING:
			return "playing"
		RunState.COMPLETE:
			return "complete"
		RunState.FAILED:
			return "failed"
		_:
			return "unknown"
