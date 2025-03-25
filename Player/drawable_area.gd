extends Area2D

const RithmaticLines = preload("res://RithmaticLines/rithmatic_lines.gd")
const Placement = preload("res://Player/placement.gd")

@export var _scroll_scale: float
@export var _line_preview: Line2D

var _is_placing_line: bool
var _placement: Placement

func _ready() -> void:
	_placement = Placement.new(RithmaticLines.Types.WARDING, Vector2())
	_is_placing_line = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		
		match mouse_event.button_index:
			MOUSE_BUTTON_LEFT:
				_is_placing_line = mouse_event.pressed
				if not _is_placing_line:
					confirm_placement()
					pass
				_placement.p0 = get_global_mouse_position()
				_placement.p1 = _placement.p0
			
			MOUSE_BUTTON_WHEEL_UP:
				_placement.change_scale(mouse_event.factor)
				
			MOUSE_BUTTON_WHEEL_DOWN:
				_placement.change_scale(-mouse_event.factor)
	
	elif event is InputEventMouseMotion:
		_placement.p1 = get_global_mouse_position()
		
	else:
		for line_type in RithmaticLines.Types.values():
			if line_type == _placement.type or not event.is_action_pressed(RithmaticLines.type_name(line_type)):
				continue
			_placement.type = line_type
			_placement.axis_scale = 1
	
	if _is_placing_line:
		_line_preview.points = _placement.to_polyline()
		
func confirm_placement() -> void:
	var new_node = Line2D.new()
	new_node.points = _placement.to_polyline()
	add_sibling(new_node)
