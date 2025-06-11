extends Line2D
class_name LinePreview

func is_valid() -> bool:
	var center : Vector2 = %DrawableArea.position
	var radius : float = %DrawableAreaCollision.shape.radius
	for p in points:
		if (p - center).length() > radius:
			return false
	return true
	
func set_valid(valid: bool) -> void:
	material.set_shader_parameter("is_valid", valid)
