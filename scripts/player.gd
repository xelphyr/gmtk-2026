extends CharacterBody2D

const speed = 300.0
const jump_velocity = -300.0
const ground_pound_vel = 1000.0
const dash_factor = 3.5
const wall_jump_factor = 1.0
const dash_friction = 0.1
const friction = 0.2


#NOTE: Make it so that friction decreases with high speed

var has_dashed = false
var can_wall_jump = false

var is_slamming = false
var slam_start_at = 0

var trigger_bounce = -1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if is_on_wall_only():
			can_wall_jump = true
			has_dashed = false
		else:
			can_wall_jump = false
		velocity += get_gravity() * delta

	if is_on_floor():
		has_dashed = false
		can_wall_jump = false

		set_deferred("is_slamming", false)


	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_velocity
		elif can_wall_jump:
			velocity = (Vector2.DOWN*jump_velocity + get_wall_normal()*speed*wall_jump_factor)
			can_wall_jump = false


	# Get the input direction
	var direction := Input.get_axis("left", "right")

	# Check if the player is trying to dash and whether they can
	var is_dashing = Input.is_action_just_pressed("dash")

	if is_dashing and not has_dashed:
		velocity.x = direction * speed * dash_factor
		has_dashed = true

	# Check if the player is ground-pounding

	var is_ground_pounding = Input.is_action_just_pressed("ground_pound")
	if is_ground_pounding and not is_on_floor() and not is_slamming:
		velocity.y = ground_pound_vel
		is_slamming = true
		slam_start_at = global_position.y

	if trigger_bounce >0:
		print(trigger_bounce)
		is_slamming = false
		var slam_height = abs(slam_start_at - global_position.y)
		velocity.y = -sqrt(2*(slam_height*trigger_bounce)*get_gravity().y)
		trigger_bounce = -1

	# movement/deceleration

	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed*dash_friction)

	else:
		velocity.x = move_toward(velocity.x, 0, speed*friction)

	move_and_slide()

func bounce(rst: float):
	trigger_bounce = rst
