extends Node

@export_file("*.tscn") var initial_game_scene_path: String = "res://game/main/main.tscn"

@onready var content_root: Node = $ContentRoot
@onready var main_menu: Control = $MainMenu
@onready var options_menu: Control = $OptionsMenu
@onready var credits_screen: Control = $CreditsScreen
@onready var shader_showcase: Control = $ShaderShowcase
@onready var pause_menu: Control = $PauseMenu
@onready var result_screen: Control = $ResultScreen
@onready var debug_overlay: CanvasLayer = $DebugOverlay
@onready var transition_rect: ColorRect = $TransitionLayer/TransitionRect

var _options_return_target: StringName = &"menu"

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	transition_rect.modulate.a = 0.0
	SceneLoader.register_app_shell(self, content_root)
	GameState.mark_boot_completed()
	SignalBus.app_shell_ready.emit()
	SignalBus.start_game_requested.connect(_on_start_game_requested)
	SignalBus.open_options_requested.connect(_on_open_options_requested)
	SignalBus.open_credits_requested.connect(_on_open_credits_requested)
	SignalBus.open_shader_showcase_requested.connect(_on_open_shader_showcase_requested)
	SignalBus.back_to_menu_requested.connect(_on_back_to_menu_requested)
	SignalBus.pause_requested.connect(_on_pause_requested)
	SignalBus.resume_game_requested.connect(_on_resume_game_requested)
	SignalBus.restart_run_requested.connect(_on_restart_run_requested)
	SignalBus.toggle_debug_requested.connect(_on_toggle_debug_requested)
	SignalBus.run_completed.connect(_on_run_completed)
	SignalBus.run_failed.connect(_on_run_failed)
	SignalBus.scene_change_failed.connect(_on_scene_change_failed)
	SignalBus.settings_changed.connect(_apply_debug_state)
	show_main_menu()

func _exit_tree() -> void:
	SceneLoader.unregister_app_shell(self)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"pause"):
		if pause_menu.visible:
			SignalBus.resume_game_requested.emit()
		elif content_root.get_child_count() > 0 and not result_screen.visible and not options_menu.visible:
			SignalBus.pause_requested.emit()
	elif event.is_action_pressed(&"restart_run") and content_root.get_child_count() > 0:
		SignalBus.restart_run_requested.emit()
	elif event.is_action_pressed(&"debug_toggle"):
		SignalBus.toggle_debug_requested.emit()

func show_main_menu() -> void:
	_options_return_target = &"menu"
	_clear_content_root()
	_set_content_paused(false)
	GameState.reset_session()
	_set_screen_visibility(true, false, false, false, false, false)
	_flash_transition()
	_apply_debug_state()

func show_options_menu() -> void:
	_options_return_target = &"pause" if content_root.get_child_count() > 0 and pause_menu.visible else &"menu"
	if _options_return_target == &"pause":
		_set_content_paused(true)
	_set_screen_visibility(false, true, false, false, false, false)
	_flash_transition()
	_apply_debug_state()

func show_credits_screen() -> void:
	_set_screen_visibility(false, false, true, false, false, false)
	_flash_transition()
	_apply_debug_state()

func show_shader_showcase() -> void:
	_set_screen_visibility(false, false, false, true, false, false)
	_flash_transition()
	_apply_debug_state()

func start_game() -> void:
	_options_return_target = &"menu"
	_set_content_paused(false)
	_set_screen_visibility(false, false, false, false, false, false)
	_flash_transition()
	SceneLoader.change_scene(_resolve_initial_scene_path())
	_apply_debug_state()

func show_pause_menu() -> void:
	_options_return_target = &"pause"
	_set_content_paused(true)
	_set_screen_visibility(false, false, false, false, true, false)
	_flash_transition()
	_apply_debug_state()

func hide_pause_menu() -> void:
	_options_return_target = &"menu"
	_set_content_paused(false)
	_set_screen_visibility(false, false, false, false, false, false)
	_apply_debug_state()

func show_result_screen(title: String, summary: String) -> void:
	if result_screen.has_method("set_result"):
		result_screen.call("set_result", title, summary)
	_set_content_paused(true)
	_set_screen_visibility(false, false, false, false, false, true)
	_flash_transition()
	_apply_debug_state()

func _resolve_initial_scene_path() -> String:
	if not GameState.active_game_scene_path.is_empty():
		return GameState.active_game_scene_path
	return initial_game_scene_path

func _clear_content_root() -> void:
	for child: Node in content_root.get_children():
		content_root.remove_child(child)
		child.queue_free()

func _set_content_paused(paused: bool) -> void:
	for child: Node in content_root.get_children():
		child.process_mode = Node.PROCESS_MODE_DISABLED if paused else Node.PROCESS_MODE_INHERIT

func _set_screen_visibility(menu_visible: bool, options_visible: bool, credits_visible: bool, showcase_visible: bool, pause_visible: bool, result_visible: bool) -> void:
	main_menu.visible = menu_visible
	options_menu.visible = options_visible
	credits_screen.visible = credits_visible
	shader_showcase.visible = showcase_visible
	pause_menu.visible = pause_visible
	result_screen.visible = result_visible

func _apply_debug_state() -> void:
	debug_overlay.visible = SettingsManager.debug_overlay_enabled

func _flash_transition() -> void:
	var duration: float = SettingsManager.transition_duration
	if duration <= 0.0:
		return
	transition_rect.modulate.a = 0.0
	var tween: Tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(transition_rect, "modulate:a", 0.35, duration * 0.5)
	tween.tween_property(transition_rect, "modulate:a", 0.0, duration * 0.5)

func _on_start_game_requested() -> void:
	start_game()

func _on_open_options_requested() -> void:
	show_options_menu()

func _on_open_credits_requested() -> void:
	show_credits_screen()

func _on_open_shader_showcase_requested() -> void:
	show_shader_showcase()

func _on_back_to_menu_requested() -> void:
	if options_menu.visible and _options_return_target == &"pause":
		show_pause_menu()
		return
	show_main_menu()

func _on_pause_requested() -> void:
	if content_root.get_child_count() > 0 and not result_screen.visible:
		show_pause_menu()

func _on_resume_game_requested() -> void:
	hide_pause_menu()

func _on_restart_run_requested() -> void:
	hide_pause_menu()
	start_game()

func _on_toggle_debug_requested() -> void:
	SettingsManager.set_debug_overlay_enabled(not SettingsManager.debug_overlay_enabled)

func _on_run_completed() -> void:
	var summary: String = "Score: %d\nScene: %s\nState: %s" % [GameState.score, GameState.active_game_scene_path, GameState.get_run_state_label()]
	show_result_screen("Run Complete", summary)

func _on_run_failed(message: String) -> void:
	show_result_screen("Run Failed", message)

func _on_scene_change_failed(scene_path: String, error_code: int) -> void:
	SignalBus.message_shown.emit("Scene load failed: %s (%d)" % [scene_path, error_code])
