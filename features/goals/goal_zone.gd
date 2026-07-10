class_name GoalZone
extends Area2D

signal reached(actor: Node2D)

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group(&"player"):
		return

	reached.emit(body)
