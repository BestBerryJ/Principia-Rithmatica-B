extends Camera2D
var zoom_out

func _process(delta):
	if Input.is_action_pressed("zoom_out"):
		zoom = Vector2(1,1)
	else:
		zoom = Vector2(2,2)
