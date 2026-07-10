extends Node

@export_file("*.tscn") var first_scene_path: String = "res://game/app/app_shell.tscn"

func _ready() -> void:
	GameState.mark_boot_started()
	call_deferred("_continue_boot")

func _continue_boot() -> void:
	SceneLoader.change_root_scene(first_scene_path)
