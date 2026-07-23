extends Node

var start_time = 600.0
var time: float
var par: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)
	EventBus.loaded_level.connect(_on_loaded_level)

	time = start_time

	call_deferred("_start_load")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_dec_time(delta)

func _dec_time(delta: float):
	time -= delta
	par -= delta

	EventBus.time_update.emit(time, par)

func _on_loaded_level(level_par: float):
	par = level_par

func _on_level_completed():
	print("donezo")
	time += (0.0 if par<0.0 else par)
	EventBus.request_load_level.emit()

func _start_load():
	EventBus.request_load_level.emit()
