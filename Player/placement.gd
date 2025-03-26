class_name Placement

var RithmaticLines : GDScript = preload("res://RithmaticLines/rithmatic_lines.gd")
var type : int #RithmaticLines.Type
var p0 : Vector2
var p1: Vector2
var axis_scale: float

func _init(_type: int, _point: Vector2) -> void:
	type = _type
	p0 = _point
	p1 = _point
	axis_scale = 1
	
func change_scale(factor: float) -> void:
	axis_scale = clamp(axis_scale + factor, 0.1, 5)
	
func to_polyline() -> Array[Vector2]:
	match type:
		RithmaticLines.Types.FORBIDDANCE:
			return [p0, p1]
		
		RithmaticLines.Types.WARDING:
			var origin : Vector2 = (p0 + p1) / 2
			var tangent : Vector2 =- (p1 - p0) / 2
			var normal : Vector2 = Vector2(-tangent.y, tangent.x) * axis_scale
			var transform : Transform2D = Transform2D(tangent, normal, origin)
			
			var points : Array[Vector2] = []
			points.resize(RithmaticLines.NUM_WARDING_SEGMENTS + 1)
			
			for i in range(RithmaticLines.NUM_WARDING_SEGMENTS + 1):
				var angle : float = i * TAU / RithmaticLines.NUM_WARDING_SEGMENTS
				points[i] = transform * Vector2(cos(angle), sin(angle))
			
			return points
		
		RithmaticLines.Types.VIGOR:
			var origin : Vector2 = p0
			var tangent : Vector2 = p1 - p0
			var normal : Vector2 = RithmaticLines.VIGOR_DEFAULT_BEAM_WIDTH * \
				axis_scale * Vector2(-tangent.y, tangent.x).normalized()
				
			var transform : Transform2D = Transform2D(tangent, normal, origin)
			
			var points : Array[Vector2] = []
			points.resize(RithmaticLines.NUM_VIGOR_SEGMENTS + 1)
			
			for i in range(RithmaticLines.NUM_VIGOR_SEGMENTS + 1):
				var x : float = float(i) / RithmaticLines.NUM_VIGOR_SEGMENTS
				points[i] = transform * Vector2(x, sin(x * 2 * TAU)) # 2 periods
			
			return points
			
		_:
			push_error("Placement.to_polyline() tried to convert invalid line type " + str(type))
			return []
