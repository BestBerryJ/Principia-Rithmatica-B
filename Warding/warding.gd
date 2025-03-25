extends Area2D

var segment = preload("res://Warding/warding_segment.tscn")
var radius

func _ready():
	radius = get_node("CircleCollision").shape.radius
	var segments = get_children()
	print(get_child_count())
	var angle = 0
	for seg in segments:
		if seg is Sprite2D:
			seg.scale = Vector2(radius/65,radius/65)
			seg.rotation_degrees = angle
			seg.position = Vector2(radius*scale[0]*cos(deg_to_rad(angle)),radius*scale[1]*sin(deg_to_rad(angle)))
			angle += 15
