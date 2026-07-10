extends Node2D

@onready var level_root: Node2D = $LevelRoot

func _ready() -> void:
	GameState.reset_run()
	level_root.process_mode = Node.PROCESS_MODE_INHERIT
