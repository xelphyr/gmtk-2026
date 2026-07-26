extends Line2D

const line_point_freq = 0
const line_points = 10

@onready var line_cooldown = line_point_freq

func _process(delta:float):
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		line_cooldown = line_point_freq
		add_point(player.global_position)
		if get_point_count() > line_points:
			remove_point(0)
	else:
		clear_points()
