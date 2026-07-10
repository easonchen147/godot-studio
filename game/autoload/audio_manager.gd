extends Node

const MIN_BUS_VOLUME_DB: float = -80.0

@export var master_bus: StringName = &"Master"
@export var sfx_bus: StringName = &"SFX"
@export var music_bus: StringName = &"Music"
@export var ui_bus: StringName = &"UI"
@export var ambience_bus: StringName = &"Ambience"

func _ready() -> void:
	SignalBus.settings_changed.connect(_on_settings_changed)
	apply_settings()

func play_ui_accept() -> void:
	# Placeholder hook. Bind an AudioStreamPlayer here once UI sounds exist.
	pass

func set_bus_volume(bus_name: StringName, linear_volume: float) -> void:
	var bus_index: int = AudioServer.get_bus_index(String(bus_name))
	if bus_index < 0:
		return
	AudioServer.set_bus_volume_db(bus_index, _linear_to_bus_db(linear_volume))

func set_bus_muted(bus_name: StringName, muted: bool) -> void:
	var bus_index: int = AudioServer.get_bus_index(String(bus_name))
	if bus_index < 0:
		return
	AudioServer.set_bus_mute(bus_index, muted)

func apply_settings() -> void:
	set_bus_volume(master_bus, SettingsManager.master_volume)
	set_bus_muted(master_bus, SettingsManager.master_muted)
	set_bus_volume(music_bus, SettingsManager.music_volume)
	set_bus_muted(music_bus, SettingsManager.music_muted)
	set_bus_volume(sfx_bus, SettingsManager.sfx_volume)
	set_bus_muted(sfx_bus, SettingsManager.sfx_muted)
	set_bus_volume(ui_bus, SettingsManager.ui_volume)
	set_bus_muted(ui_bus, SettingsManager.ui_muted)
	set_bus_volume(ambience_bus, SettingsManager.ambience_volume)
	set_bus_muted(ambience_bus, SettingsManager.ambience_muted)
	SignalBus.audio_settings_applied.emit()

func _on_settings_changed() -> void:
	apply_settings()

func _linear_to_bus_db(linear_volume: float) -> float:
	var clamped_volume: float = clampf(linear_volume, 0.0, 1.0)
	if clamped_volume <= 0.0:
		return MIN_BUS_VOLUME_DB
	return linear_to_db(clamped_volume)
