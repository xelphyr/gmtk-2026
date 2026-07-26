extends Camera2D

const offset_factor = 0.01
const cam_shake_max = 7.0
const cam_shake_speed = 0.1
# Called every frame. 'delta' is the elapsed time since the previous frame.

@export var cam_shake_curve : Curve

var camshake_offset = Vector2.ZERO
@onready var cam_shake_cooldown = cam_shake_speed

func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("Player")

	cam_shake_cooldown -= delta
	if cam_shake_cooldown < 0.0:
		camshake_offset = Vector2(randf()*cam_shake_max, randf()*cam_shake_max) * cam_shake_curve.sample(1-GameManager.time/GameManager.start_time)

	if player:
		offset = -(global_position - player.global_position)*offset_factor + camshake_offset
