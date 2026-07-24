extends Area2D

@export var id: int
## `true` means that it is on, `false` means that it is off
@export var state: bool

## Restitution when the button is pressed when `state=true`, and the button transitions into `state=false`
const ON_RST = 0.5

## Restitution when the button is pressed when `state=false`, and the button transitions into `state=true`
const OFF_RST = 1.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.button_toggle.connect(set_state)
	set_state(id, state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turn_off():
	state = false

func turn_on():
	state=true

func trigger_toggle():
	EventBus.button_toggle.emit(id, !state)

func set_state(i:int, s:bool):
	if i == id:
		if s:
			turn_on()
		else:
			turn_off()

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		if body.is_slamming:
			body.bounce(ON_RST if state else OFF_RST)
			trigger_toggle()
