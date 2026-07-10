extends Control

const UI_THEME_HELPER: GDScript = preload("res://features/ui/common/ui_theme_helper.gd")
const PREVIEW_SIZE: int = 96

const SHADER_ENTRIES: Array[Dictionary] = [
	{
		"name": "2D Outer Outline",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_outline_2d_outer.gdshader"),
		"params": {"line_color": Color(0.15, 0.95, 0.72, 1.0), "line_thickness": 4.0}
	},
	{
		"name": "2D Dissolve",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_dissolve_2d.gdshader"),
		"params": {"burn_color": Color(1.0, 0.62, 0.18, 1.0), "burn_size": 0.14, "dissolve_amount": 0.42, "emission_amount": 1.0}
	},
	{
		"name": "Glow Prepass",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_glow_prepass.gdshader"),
		"params": {"glow_color": Color(0.25, 0.7, 1.0, 1.0)}
	},
	{
		"name": "Gaussian Blur",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_gaussian_blur.gdshader"),
		"params": {"blur_scale": Vector2(1.4, 0.8)}
	},
	{
		"name": "Invert",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_invert.gdshader"),
		"params": {}
	},
	{
		"name": "Pointilism",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_pointilism.gdshader"),
		"params": {"size": 0.04}
	},
	{
		"name": "Shockwave",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_shockwave.gdshader"),
		"params": {"displacement_amount": 0.035}
	},
	{
		"name": "Value Noise",
		"shader": preload("res://assets/runtime/shaders/gdquest/canvas_value_noise.gdshader"),
		"params": {}
	}
]

@onready var grid: GridContainer = %Grid
@onready var source_label: Label = %SourceLabel

var _base_texture: Texture2D
var _noise_texture: Texture2D
var _mask_texture: Texture2D

func _ready() -> void:
	UI_THEME_HELPER.apply_theme(self)
	_base_texture = _create_base_texture()
	_noise_texture = _create_noise_texture()
	_mask_texture = _create_mask_texture()
	source_label.text = "GDQuest shader subset: MIT shader source only; no upstream art assets imported."
	_populate_grid()

func _populate_grid() -> void:
	for entry: Dictionary in SHADER_ENTRIES:
		grid.add_child(_create_shader_card(entry))

func _create_shader_card(entry: Dictionary) -> PanelContainer:
	var panel: PanelContainer = PanelContainer.new()
	panel.custom_minimum_size = Vector2(180.0, 164.0)

	var box: VBoxContainer = VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 8)
	panel.add_child(box)

	var title: Label = Label.new()
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.text = str(entry["name"])
	box.add_child(title)

	var preview: TextureRect = TextureRect.new()
	preview.custom_minimum_size = Vector2(PREVIEW_SIZE, PREVIEW_SIZE)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	preview.texture = _base_texture
	preview.material = _create_material(entry)
	box.add_child(preview)

	return panel

func _create_material(entry: Dictionary) -> ShaderMaterial:
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = entry["shader"] as Shader

	var params: Dictionary = entry["params"] as Dictionary
	for key: Variant in params.keys():
		material.set_shader_parameter(StringName(str(key)), params[key])

	if material.shader != null:
		material.set_shader_parameter(&"dissolve_texture", _noise_texture)
		material.set_shader_parameter(&"mask_texture", _mask_texture)

	return material

func _create_base_texture() -> Texture2D:
	var image: Image = Image.create(PREVIEW_SIZE, PREVIEW_SIZE, false, Image.FORMAT_RGBA8)
	var center: Vector2 = Vector2(PREVIEW_SIZE, PREVIEW_SIZE) * 0.5
	var radius: float = float(PREVIEW_SIZE) * 0.42

	for y in PREVIEW_SIZE:
		for x in PREVIEW_SIZE:
			var position: Vector2 = Vector2(x, y)
			var distance: float = position.distance_to(center)
			var alpha: float = 1.0 if distance <= radius else 0.0
			var stripe: float = 0.22 if int((x + y) / 12) % 2 == 0 else 0.0
			var color: Color = Color(0.2 + stripe + float(x) / float(PREVIEW_SIZE) * 0.35, 0.46 + stripe, 0.86, alpha)
			image.set_pixel(x, y, color)

	return ImageTexture.create_from_image(image)

func _create_noise_texture() -> Texture2D:
	var image: Image = Image.create(PREVIEW_SIZE, PREVIEW_SIZE, false, Image.FORMAT_RGBA8)
	for y in PREVIEW_SIZE:
		for x in PREVIEW_SIZE:
			var value: float = fposmod(sin(float(x) * 12.9898 + float(y) * 78.233) * 43758.5453, 1.0)
			image.set_pixel(x, y, Color(value, value, value, 1.0))
	return ImageTexture.create_from_image(image)

func _create_mask_texture() -> Texture2D:
	var image: Image = Image.create(PREVIEW_SIZE, PREVIEW_SIZE, false, Image.FORMAT_RGBA8)
	var center: Vector2 = Vector2(PREVIEW_SIZE, PREVIEW_SIZE) * 0.5
	for y in PREVIEW_SIZE:
		for x in PREVIEW_SIZE:
			var distance: float = Vector2(x, y).distance_to(center) / (float(PREVIEW_SIZE) * 0.5)
			var ring: float = smoothstep(0.18, 0.32, distance) * (1.0 - smoothstep(0.58, 0.76, distance))
			image.set_pixel(x, y, Color(ring, ring, ring, 1.0))
	return ImageTexture.create_from_image(image)

func _on_back_pressed() -> void:
	SignalBus.back_to_menu_requested.emit()
