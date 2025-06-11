extends Area2D

@export var _scroll_scale: float = 1
@export var _draw_speed : float = 5

@onready var _preview : LinePreview = %LinePreview
@onready var _action_queue : ActionQueue = %ActionQueue
@onready var _local_world : Node2D = %LocalWorld
@onready var _shared_world : Node2D = owner.shared_world

var _is_placing_line: bool
var _placement: Placement

func _ready() -> void:
	_placement = Placement.new()
	_is_placing_line = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event as InputEventMouseButton

		match mouse_event.button_index:
			MOUSE_BUTTON_LEFT:
				_is_placing_line = mouse_event.pressed
				if not _is_placing_line:
					if (_preview.is_valid()):
						confirm_placement()
					else:
						_preview.clear_points()
				_placement.p0 = get_global_mouse_position()
				_placement.p1 = _placement.p0
			
			MOUSE_BUTTON_WHEEL_UP:
				_placement.change_scale(mouse_event.factor * _scroll_scale)
				
			MOUSE_BUTTON_WHEEL_DOWN:
				_placement.change_scale(-mouse_event.factor * _scroll_scale)

	elif event is InputEventMouseMotion:
		_placement.p1 = get_global_mouse_position()

	else:
		for line_type : int in RithmaticLines.Types.values():
			if line_type == _placement.type or not event.is_action_pressed(RithmaticLines.type_name(line_type)):
				continue
			_placement.type = line_type
			_placement.axis_scale = 1

	if _is_placing_line:
		_preview.points = _placement.to_polyline()
		var valid : bool = _preview.is_valid()
		_preview.set_valid(valid)
		
func confirm_placement() -> void:
	var line_node : Line2D = _preview.duplicate()
	line_node.material = _preview.material.duplicate()
	var draw_action : DrawAction = DrawAction.new(_local_world, _shared_world, line_node, _placement, _draw_speed)
	_action_queue.enqueue(draw_action)
