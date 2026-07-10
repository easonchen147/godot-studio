class_name Pickup
extends Area2D

signal collected(collector: Node2D)

@export var value: int = 1
@export var collect_message: String = "Pickup collected. Reach the green goal."

var _collected: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func reset_pickup() -> void:
	_collected = false
	visible = true
	set_deferred("monitoring", true)

func _on_body_entered(body: Node2D) -> void:
	if _collected or not body.is_in_group(&"player"):
		return

	_collected = true
	visible = false
	set_deferred("monitoring", false)
	collected.emit(body)
