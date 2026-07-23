extends Node

var start_time = 600.0
var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = start_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time -= delta
	EventBus.time_update.emit(time)
