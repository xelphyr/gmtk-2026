extends Camera2D

const offset_factor = 0.01

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_d: float) -> void:
	var player = get_tree().get_first_node_in_group("Player")

	if player:
		offset = -(global_position - player.global_position)*offset_factor
