class_name InputBootstrap
extends RefCounted

static func ensure_default_actions() -> void:
	_add_key(&"move_left", KEY_A)
	_add_key(&"move_left", KEY_LEFT)
	_add_joypad_button(&"move_left", JOY_BUTTON_DPAD_LEFT)
	_add_joypad_axis(&"move_left", JOY_AXIS_LEFT_X, -1.0)
	_add_key(&"move_right", KEY_D)
	_add_key(&"move_right", KEY_RIGHT)
	_add_joypad_button(&"move_right", JOY_BUTTON_DPAD_RIGHT)
	_add_joypad_axis(&"move_right", JOY_AXIS_LEFT_X, 1.0)
	_add_key(&"move_up", KEY_W)
	_add_key(&"move_up", KEY_UP)
	_add_joypad_button(&"move_up", JOY_BUTTON_DPAD_UP)
	_add_joypad_axis(&"move_up", JOY_AXIS_LEFT_Y, -1.0)
	_add_key(&"move_down", KEY_S)
	_add_key(&"move_down", KEY_DOWN)
	_add_joypad_button(&"move_down", JOY_BUTTON_DPAD_DOWN)
	_add_joypad_axis(&"move_down", JOY_AXIS_LEFT_Y, 1.0)
	_add_key(&"interact", KEY_E)
	_add_key(&"interact", KEY_ENTER)
	_add_joypad_button(&"interact", JOY_BUTTON_A)
	_add_key(&"jump", KEY_SPACE)
	_add_joypad_button(&"jump", JOY_BUTTON_X)
	_add_key(&"pause", KEY_ESCAPE)
	_add_key(&"pause", KEY_P)
	_add_joypad_button(&"pause", JOY_BUTTON_START)
	_add_key(&"restart_run", KEY_R)
	_add_joypad_button(&"restart_run", JOY_BUTTON_BACK)
	_add_key(&"debug_toggle", KEY_F3)

static func _add_key(action: StringName, physical_keycode: Key) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)

	for event: InputEvent in InputMap.action_get_events(action):
		if event is InputEventKey and event.physical_keycode == physical_keycode:
			return

	var key_event: InputEventKey = InputEventKey.new()
	key_event.physical_keycode = physical_keycode
	InputMap.action_add_event(action, key_event)

static func _add_joypad_button(action: StringName, button_index: JoyButton) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)

	for event: InputEvent in InputMap.action_get_events(action):
		if event is InputEventJoypadButton and event.button_index == button_index:
			return

	var joypad_event: InputEventJoypadButton = InputEventJoypadButton.new()
	joypad_event.button_index = button_index
	joypad_event.pressed = true
	InputMap.action_add_event(action, joypad_event)

static func _add_joypad_axis(action: StringName, axis: JoyAxis, axis_value: float) -> void:
	if not InputMap.has_action(action):
		InputMap.add_action(action)

	for event: InputEvent in InputMap.action_get_events(action):
		if event is InputEventJoypadMotion and event.axis == axis and is_equal_approx(event.axis_value, axis_value):
			return

	var axis_event: InputEventJoypadMotion = InputEventJoypadMotion.new()
	axis_event.axis = axis
	axis_event.axis_value = axis_value
	InputMap.action_add_event(action, axis_event)
