extends Node2D

@export var levels : Array[Level]

func _ready():
	EventBus.request_load_level.connect(_on_request_load_level)


func _on_request_load_level():
	print("hi")
	for child in get_children():
		child.call_deferred("queue_free")
	var selected_level : Level = levels.pick_random()
	var level_scene = selected_level.level_scene.instantiate()
	call_deferred("add_child", level_scene)
	level_scene.level_completed.connect(_on_level_completed)
	EventBus.loaded_level.emit(selected_level.par)

func _on_level_completed():
	EventBus.level_completed.emit()
