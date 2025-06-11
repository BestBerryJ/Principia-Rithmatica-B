extends TextureRect

class_name PlayerAction
const ICON_SIZE = Vector2(100, 100)
var completion_time : float

func _init(icon : Texture) -> void:
	texture = icon
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	custom_minimum_size = ICON_SIZE

func complete() -> void:
	assert(false, "complete() must be implemented for action subclass")

func set_progress(_t : float) -> void:
	assert(false, "set_progress() must be implemented for action subclass")
