extends Node

signal scene_change_started(scene_path: String)
signal scene_changed(scene_path: String)
signal scene_change_failed(scene_path: String, error_code: int)

var _app_shell: Node = null
var _content_root: Node = null

func change_scene(scene_path: String) -> void:
	call_deferred("_change_scene_deferred", scene_path)

func change_root_scene(scene_path: String) -> void:
	call_deferred("_change_root_scene_deferred", scene_path)

func register_app_shell(app_shell: Node, content_root: Node) -> void:
	_app_shell = app_shell
	_content_root = content_root

func unregister_app_shell(app_shell: Node) -> void:
	if _app_shell == app_shell:
		_app_shell = null
		_content_root = null

func _change_scene_deferred(scene_path: String) -> void:
	if scene_path.is_empty():
		_emit_scene_change_failed(scene_path, ERR_INVALID_PARAMETER)
		return

	if scene_path == GameState.APP_SHELL_SCENE_PATH:
		_change_root_scene_deferred(scene_path)
		return

	if _can_use_app_shell():
		_replace_app_shell_content(scene_path)
		return

	_change_root_scene_deferred(scene_path)

func _change_root_scene_deferred(scene_path: String) -> void:
	if scene_path.is_empty():
		_emit_scene_change_failed(scene_path, ERR_INVALID_PARAMETER)
		return

	_emit_scene_change_started(scene_path)
	var error_code: Error = get_tree().change_scene_to_file(scene_path)
	if error_code != OK:
		_emit_scene_change_failed(scene_path, error_code)
		return

	_emit_scene_changed(scene_path)

func _replace_app_shell_content(scene_path: String) -> void:
	_emit_scene_change_started(scene_path)

	var packed_scene: PackedScene = load(scene_path) as PackedScene
	if packed_scene == null:
		_emit_scene_change_failed(scene_path, ERR_CANT_OPEN)
		return

	for child: Node in _content_root.get_children():
		_content_root.remove_child(child)
		child.queue_free()

	var next_scene: Node = packed_scene.instantiate()
	_content_root.add_child(next_scene)
	GameState.set_active_game_scene(scene_path)
	_emit_scene_changed(scene_path)

func _can_use_app_shell() -> bool:
	return _app_shell != null and is_instance_valid(_app_shell) and _content_root != null and is_instance_valid(_content_root)

func _emit_scene_change_started(scene_path: String) -> void:
	scene_change_started.emit(scene_path)
	SignalBus.scene_change_started.emit(scene_path)

func _emit_scene_changed(scene_path: String) -> void:
	scene_changed.emit(scene_path)
	SignalBus.scene_changed.emit(scene_path)

func _emit_scene_change_failed(scene_path: String, error_code: int) -> void:
	scene_change_failed.emit(scene_path, error_code)
	SignalBus.scene_change_failed.emit(scene_path, error_code)
