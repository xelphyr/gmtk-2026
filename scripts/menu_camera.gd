extends Camera2D

const offset_factor = 0.001

func _process(delta: float) -> void:
	offset = get_local_mouse_position()*offset_factor
