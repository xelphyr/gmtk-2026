extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
@export var ground_pound_vel = 1000.0
@export var dash_factor = 5.0
@export var wall_jump_factor = 1.0
@export var dash_friction = 0.1
@export var wall_friction = 0.15
@export var wall_slide_speed = 100
@export var friction = 0.2

#NOTE: Make it so that friction decreases with high speed


var has_dashed = false
var can_wall_jump = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if is_on_wall_only():
			can_wall_jump = true
			has_dashed = false
			velocity.y = move_toward(velocity.y, wall_slide_speed, abs(jump_velocity)*wall_friction)
		velocity += get_gravity() * delta

	if is_on_floor():
		has_dashed = false
		can_wall_jump = false


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
	if is_ground_pounding and not is_on_floor():
		velocity.y = ground_pound_vel



	# movement/deceleration

	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed*dash_friction)

	else:
		velocity.x = move_toward(velocity.x, 0, speed*friction)

	move_and_slide()
