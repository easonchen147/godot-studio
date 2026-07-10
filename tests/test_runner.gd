extends SceneTree

const REQUIRED_ACTIONS: Array[StringName] = [
	&"move_left",
	&"move_right",
	&"move_up",
	&"move_down",
	&"interact",
	&"jump",
	&"pause",
	&"restart_run",
	&"debug_toggle"
]

const REQUIRED_SCENES: Array[String] = [
	"res://game/boot/boot.tscn",
	"res://game/app/app_shell.tscn",
	"res://game/main/main.tscn",
	"res://features/levels/level_001/level_001.tscn",
	"res://features/ui/menu/main_menu.tscn",
	"res://features/ui/menu/options_menu.tscn",
	"res://features/ui/menu/pause_menu.tscn",
	"res://features/ui/results/result_screen.tscn",
	"res://features/ui/debug/debug_overlay.tscn",
	"res://features/vfx/shader_showcase/shader_showcase.tscn"
]

const GLOBAL_CLASS_SCRIPT_ORDER: Array[String] = [
	"res://features/player/player.gd",
	"res://features/pickups/pickup.gd",
	"res://features/goals/goal_zone.gd",
	"res://features/levels/level_001/level_001.gd"
]

var _failures: int = 0
var _checks: int = 0

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	print("[tests] Godot Studio starter test runner")
	_test_input_bootstrap()
	_test_game_state()
	_test_settings_persistence()
	_warm_up_global_classes()
	_test_required_scenes_load()
	_test_gdquest_shaders_load()
	await _test_first_playable_flow()

	if _failures == 0:
		print("[tests] PASS: %d checks" % _checks)
	else:
		push_error("[tests] FAIL: %d failures across %d checks" % [_failures, _checks])
	quit(_failures)

func _test_input_bootstrap() -> void:
	print("[tests] input bootstrap")
	var input_bootstrap: GDScript = load("res://shared/utils/input_bootstrap.gd") as GDScript
	_expect(input_bootstrap != null, "InputBootstrap script loads")
	if input_bootstrap != null:
		input_bootstrap.ensure_default_actions()

	for action: StringName in REQUIRED_ACTIONS:
		_expect(InputMap.has_action(action), "InputMap has %s" % String(action))
		_expect(InputMap.action_get_events(action).size() > 0, "InputMap %s has events" % String(action))

func _test_game_state() -> void:
	print("[tests] game state")
	var game_state: Node = _get_autoload(&"GameState")
	if game_state == null:
		_expect(false, "GameState autoload exists")
		return

	game_state.call("reset_run")
	_expect(int(game_state.get("score")) == 0, "reset_run resets score")
	_expect(StringName(game_state.get("session_state")) == &"gameplay", "reset_run sets gameplay session")
	_expect(str(game_state.call("get_run_state_label")) == "playing", "reset_run enters playing state")

	game_state.call("add_score", 3)
	_expect(int(game_state.get("score")) == 3, "add_score increments score")

	game_state.call("complete_run")
	_expect(str(game_state.call("get_run_state_label")) == "complete", "complete_run sets complete state")

	game_state.call("reset_session")
	_expect(str(game_state.call("get_run_state_label")) == "ready", "reset_session sets ready state")
	_expect(StringName(game_state.get("session_state")) == &"menu", "reset_session sets menu session")

func _test_settings_persistence() -> void:
	print("[tests] settings persistence")
	var settings_manager: Node = _get_autoload(&"SettingsManager")
	if settings_manager == null:
		_expect(false, "SettingsManager autoload exists")
		return

	var previous_master_volume: float = float(settings_manager.get("master_volume"))
	var previous_music_muted: bool = bool(settings_manager.get("music_muted"))
	var previous_debug: bool = bool(settings_manager.get("debug_overlay_enabled"))

	settings_manager.call("set_master_volume", 0.42)
	settings_manager.call("set_music_muted", true)
	settings_manager.call("set_debug_overlay_enabled", true)

	var config: ConfigFile = ConfigFile.new()
	var error_code: Error = config.load("user://settings.cfg")
	_expect(error_code == OK, "settings file saves")
	_expect(is_equal_approx(float(config.get_value("audio", "master_volume", -1.0)), 0.42), "master volume persists")
	_expect(bool(config.get_value("audio", "music_muted", false)) == true, "music mute persists")
	_expect(bool(config.get_value("ui", "debug_overlay_enabled", false)) == true, "debug overlay persists")

	settings_manager.call("set_master_volume", previous_master_volume)
	settings_manager.call("set_music_muted", previous_music_muted)
	settings_manager.call("set_debug_overlay_enabled", previous_debug)

func _test_required_scenes_load() -> void:
	print("[tests] required scenes")
	for scene_path: String in REQUIRED_SCENES:
		_expect(ResourceLoader.exists(scene_path), "scene exists: %s" % scene_path)
		var packed_scene: PackedScene = load(scene_path) as PackedScene
		_expect(packed_scene != null, "scene loads: %s" % scene_path)
		if packed_scene != null:
			var instance: Node = packed_scene.instantiate()
			_expect(instance != null, "scene instantiates: %s" % scene_path)
			if instance != null:
				instance.queue_free()

func _warm_up_global_classes() -> void:
	print("[tests] global class warmup")
	for script_path: String in GLOBAL_CLASS_SCRIPT_ORDER:
		var script: GDScript = load(script_path) as GDScript
		_expect(script != null, "global class script loads: %s" % script_path)

func _test_gdquest_shaders_load() -> void:
	print("[tests] GDQuest shader subset")
	var shader_dir: String = "res://assets/runtime/shaders/gdquest"
	var files: PackedStringArray = DirAccess.get_files_at(shader_dir)
	var shader_count: int = 0

	for file_name: String in files:
		if not file_name.ends_with(".gdshader"):
			continue
		shader_count += 1
		var shader_path: String = "%s/%s" % [shader_dir, file_name]
		var shader: Shader = load(shader_path) as Shader
		_expect(shader != null, "shader loads: %s" % shader_path)

	_expect(shader_count >= 20, "GDQuest shader subset has expected file count")

func _test_first_playable_flow() -> void:
	print("[tests] first playable integration flow")
	var app_shell_scene: PackedScene = load("res://game/app/app_shell.tscn") as PackedScene
	_expect(app_shell_scene != null, "AppShell scene loads for integration flow")
	if app_shell_scene == null:
		return

	var game_state: Node = _get_autoload(&"GameState")
	_expect(game_state != null, "GameState autoload exists for integration flow")
	if game_state == null:
		return
	game_state.call("reset_session")
	var app_shell: Node = app_shell_scene.instantiate()
	root.add_child(app_shell)
	await process_frame

	app_shell.call("start_game")
	await process_frame
	await process_frame

	var content_root: Node = app_shell.get_node_or_null("ContentRoot")
	_expect(content_root != null, "AppShell exposes ContentRoot")
	if content_root == null:
		await _cleanup_integration_app_shell(app_shell, game_state)
		return

	_expect(content_root.get_child_count() == 1, "starting the sample creates one gameplay child")
	if content_root.get_child_count() != 1:
		await _cleanup_integration_app_shell(app_shell, game_state)
		return

	var gameplay: Node = content_root.get_child(0)
	var player: Node2D = gameplay.get_node_or_null("LevelRoot/World/Player") as Node2D
	var pickup: Area2D = gameplay.get_node_or_null("LevelRoot/World/Pickup") as Area2D
	var goal_zone: Area2D = gameplay.get_node_or_null("LevelRoot/World/GoalZone") as Area2D
	var score_label: Label = gameplay.get_node_or_null("HUD/Root/ScoreLabel") as Label
	var result_screen: Control = app_shell.get_node_or_null("ResultScreen") as Control

	_expect(player != null, "integration flow resolves the real player")
	_expect(pickup != null, "integration flow resolves the pickup")
	_expect(goal_zone != null, "integration flow resolves the goal zone")
	_expect(score_label != null, "integration flow resolves the HUD score label")
	_expect(result_screen != null, "integration flow resolves the result screen")
	if player == null or pickup == null or goal_zone == null or score_label == null or result_screen == null:
		await _cleanup_integration_app_shell(app_shell, game_state)
		return

	pickup.body_entered.emit(player)
	await process_frame
	_expect(int(game_state.get("score")) == int(pickup.get("value")), "pickup updates GameState score")
	_expect(score_label.text == "Score: %d" % int(game_state.get("score")), "pickup updates HUD score text")

	goal_zone.body_entered.emit(player)
	await process_frame
	_expect(str(game_state.call("get_run_state_label")) == "complete", "goal completes the run after pickup")
	_expect(result_screen.visible, "completion makes the result screen visible")

	var restart_button: Button = result_screen.get_node_or_null("Panel/VBox/RestartButton") as Button
	_expect(restart_button != null, "integration flow resolves the public restart button")
	if restart_button == null:
		await _cleanup_integration_app_shell(app_shell, game_state)
		return

	restart_button.pressed.emit()
	await process_frame
	await process_frame
	_expect(not result_screen.visible, "restart hides the result screen")
	_expect(content_root.get_child_count() == 1, "restart creates one fresh gameplay child")
	_expect(int(game_state.get("score")) == 0, "restart resets score")
	_expect(str(game_state.call("get_run_state_label")) == "playing", "restart returns to playing state")

	await _cleanup_integration_app_shell(app_shell, game_state)

func _cleanup_integration_app_shell(app_shell: Node, game_state: Node) -> void:
	if is_instance_valid(app_shell):
		app_shell.queue_free()
	await process_frame
	if game_state != null:
		game_state.call("reset_session")

func _expect(condition: bool, label: String) -> void:
	_checks += 1
	if condition:
		print("[tests] ok - %s" % label)
		return

	_failures += 1
	push_error("[tests] not ok - %s" % label)

func _get_autoload(autoload_name: StringName) -> Node:
	return root.get_node_or_null(NodePath(String(autoload_name)))
