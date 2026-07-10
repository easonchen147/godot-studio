extends CanvasLayer

@onready var score_label: Label = $Root/ScoreLabel
@onready var state_label: Label = $Root/StateLabel

func _ready() -> void:
	SignalBus.score_changed.connect(_on_score_changed)
	SignalBus.run_completed.connect(_on_run_completed)
	SignalBus.run_reset.connect(_on_run_reset)
	SignalBus.message_shown.connect(_on_message_shown)
	_on_score_changed(GameState.score)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: %d" % new_score

func _on_run_completed() -> void:
	state_label.text = "Complete. First playable loop works."

func _on_run_reset() -> void:
	state_label.text = "Collect the pickup."

func _on_message_shown(message: String) -> void:
	state_label.text = message

