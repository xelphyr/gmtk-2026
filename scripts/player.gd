extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
@export var dash_factor = 5.0
@export var dash_friction = 0.1
@export var friction = 0.2

var has_dashed = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		has_dashed = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity



	# Get the input direction
	var direction := Input.get_axis("left", "right")

	# Check if the player is trying to dash and whether they can
	var is_dashing = Input.is_action_just_pressed("dash")

	if is_dashing and not has_dashed:
		velocity.x = direction * speed * dash_factor
		has_dashed = true

	# movement/deceleration

	if direction:
		if abs(velocity.x) > abs(direction * speed):
			velocity.x = move_toward(velocity.x, direction * speed, speed*dash_friction)
		else:
			velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed*friction)

	move_and_slide()
