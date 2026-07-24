extends StaticBody2D

@export var id: int
## `true` means that it is on, `false` means that it is off
@export var state: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.button_toggle.connect(set_state)
	set_state(id, state)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func turn_off():
	state = false
	collision_layer = 0
	visible=false

func turn_on():
	state=true
	collision_layer = 1
	visible=true

func set_state(i:int, s:bool):
	if i == id:
		if s:
			turn_on()
		else:
			turn_off()
