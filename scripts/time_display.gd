extends Node

@export var time_display: Label
@export var ms_display: Label

func _ready():
	EventBus.time_update.connect(_on_time_update)


func _on_time_update(time:float):
	var minutes = floor(time/60.0)
	var seconds = int(floor(time))%60
	var ms = (time - floor(time)) * 100.0

	time_display.text = "%02.f:%02d" % [minutes, seconds]
	ms_display.text = "%02.f" % ms
