extends Node

@export var _draw_speed: float
#TODO: Probably add some UI to the DrawAction (hence the 1 node scene)

var _line: Line2D # This will have fill.gdshader as its material and be set before _ready
var _placement: Placement
var completion_time: float

func _ready() -> void:
	var line_length: float = 0
	for i in range(_line.get_point_count() - 1):
		line_length += _line.get_point_position(i).distance_to(_line.get_point_position(i + 1))
		
	completion_time = line_length / _draw_speed / _line.width
	
func set_progress(t: float) -> void:
	_line.material.set_shader_parameter("fill_length", t * _draw_speed)
	
func complete() -> void:
	# TODO: actually convert placement into physics object and add as sibling
	get_parent().add_sibling(_line.duplicate(0))
	_line.queue_free()
