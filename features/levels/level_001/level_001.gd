extends Node2D

@onready var pickup: Area2D = $World/Pickup
@onready var goal_zone: Area2D = $World/GoalZone

var _has_pickup: bool = false

func _ready() -> void:
	pickup.connect(&"collected", _on_pickup_collected)
	goal_zone.connect(&"reached", _on_goal_reached)
	SignalBus.message_shown.emit("Collect the yellow pickup, then reach the green goal.")

func _on_pickup_collected(_collector: Node2D) -> void:
	_has_pickup = true
	GameState.add_score(int(pickup.get("value")))
	SignalBus.message_shown.emit(str(pickup.get("collect_message")))

func _on_goal_reached(_actor: Node2D) -> void:
	if _has_pickup:
		GameState.complete_run()
	else:
		SignalBus.message_shown.emit("Collect the yellow pickup first.")
