class_name StateMachine
extends Node

signal state_changed(previous_state: Node, next_state: Node)

@export var initial_state_path: NodePath

var current_state: Node = null

func _ready() -> void:
	if initial_state_path != NodePath():
		change_state(get_node(initial_state_path))

func _process(delta: float) -> void:
	if current_state != null and current_state.has_method("update"):
		current_state.call("update", delta)

func _physics_process(delta: float) -> void:
	if current_state != null and current_state.has_method("physics_update"):
		current_state.call("physics_update", delta)

func change_state(next_state: Node) -> void:
	if next_state == null or next_state == current_state:
		return

	var previous_state: Node = current_state
	if current_state != null and current_state.has_method("exit"):
		current_state.call("exit")

	current_state = next_state

	if current_state.has_method("enter"):
		current_state.call("enter")

	state_changed.emit(previous_state, current_state)

