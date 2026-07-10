class_name ItemData
extends Resource

enum ItemType { CONSUMABLE, EQUIPMENT, MATERIAL, QUEST, CURRENCY }

@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D
@export var item_type: ItemType = ItemType.CONSUMABLE
@export var max_stack: int = 1
@export var is_stackable: bool = false

