extends PlayerAction
class_name DrawAction

var _local_world : Node2D
var _shared_world : Node2D
var _line: Line2D
var _placement: Placement
var _draw_speed : float

func _init(local_world: Node2D, shared_world: Node2D, line: Line2D, placement : Placement, draw_speed : float = 1) -> void:
	_local_world = local_world
	_shared_world = shared_world
	_line = line
	_placement = placement
	_draw_speed = draw_speed
	
	var icon : Texture = load(
		"res://assets/action_icons/{0}_icon.png".format(
			[RithmaticLines.type_name(placement.type)]
		)
	)
	super(icon)

	var line_length: float = 0
	for i in range(_line.get_point_count() - 1):
		line_length += _line.get_point_position(i).distance_to(_line.get_point_position(i + 1))
	completion_time = line_length / draw_speed / _line.width

func _ready() -> void:
	_local_world.add_child(_line)
	
func set_progress(t: float) -> void:
	_line.material.set_shader_parameter("fill_length", t * _draw_speed)
	
func complete() -> void:
	# TODO: actually convert placement into physics object and add as sibling
	_shared_world.add_child(_line.duplicate(0))
	_line.queue_free()
