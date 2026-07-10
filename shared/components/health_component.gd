class_name HealthComponent
extends Node

signal health_changed(current_health: int, max_health: int)
signal died()

@export var max_health: int = 3
@export var invincible_time: float = 0.25

var current_health: int = 3
var _invincible_seconds: float = 0.0

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func _process(delta: float) -> void:
	_invincible_seconds = maxf(0.0, _invincible_seconds - delta)

func take_damage(amount: int) -> void:
	if amount <= 0 or _invincible_seconds > 0.0:
		return

	current_health = clampi(current_health - amount, 0, max_health)
	_invincible_seconds = invincible_time
	health_changed.emit(current_health, max_health)

	if current_health <= 0:
		died.emit()

func heal(amount: int) -> void:
	if amount <= 0:
		return

	current_health = clampi(current_health + amount, 0, max_health)
	health_changed.emit(current_health, max_health)

