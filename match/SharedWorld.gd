extends Node2D

var drawable_regions : Dictionary = {} 

func try_spawn_line(peer_id: int, req: Dictionary) -> void:
	var p0: Vector2 = req.p0
	var p1: Vector2 = req.p1
	
	var line := Line2D.new()
	line.width = req.width
	line.default_color = req.color  # or set material here
	line.points = PackedVector2Array([p0, p1])
	$Lines.add_child(line)
