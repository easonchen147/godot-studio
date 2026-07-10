class_name PlayerController
extends CharacterBody2D

@export var move_speed: float = 260.0
@export var acceleration: float = 1800.0
@export var friction: float = 2200.0
@export var play_bounds: Rect2 = Rect2(Vector2(32, 32), Vector2(1216, 656))

func _ready() -> void:
	add_to_group(&"player")

func _physics_process(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var target_velocity: Vector2 = input_vector * move_speed
	var rate: float = acceleration if input_vector.length_squared() > 0.0 else friction

	velocity = velocity.move_toward(target_velocity, rate * delta)
	move_and_slide()

	global_position = global_position.clamp(play_bounds.position, play_bounds.position + play_bounds.size)
	SignalBus.player_moved.emit(global_position)
