extends Area2D # TODO: actually only allow drawing within the area bounds

const draw_action_scene : PackedScene = preload("res://Player/DrawAction.tscn")

@export var _scroll_scale: float
@export var _line_preview: Line2D
@export var _action_queue: ActionQueue

var _is_placing_line: bool
var _placement: Placement

func _ready() -> void:
	_placement = Placement.new(RithmaticLines.Types.WARDING, Vector2())
	_is_placing_line = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event : InputEventMouseButton = event as InputEventMouseButton
		
		match mouse_event.button_index:
			MOUSE_BUTTON_LEFT:
				_is_placing_line = mouse_event.pressed
				if not _is_placing_line:
					confirm_placement()
					pass
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
		_line_preview.points = _placement.to_polyline()
		
func confirm_placement() -> void:
	var line_node : Line2D = _line_preview.duplicate()
	line_node.material = _line_preview.material.duplicate()
	var draw_action : Node = draw_action_scene.instantiate()
	draw_action._line = line_node
	draw_action.add_child(line_node)
	_action_queue.enqueue(draw_action)
