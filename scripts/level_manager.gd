extends Node2D

@export var levels : Array[Level]

func _ready():
	EventBus.level_completed.connect(_load_next_level)
	EventBus.request_load_level.connect(_load_next_level)


func _load_next_level():
	for child in get_children():
		child.call_deferred("queue_free")
	var selected_level : Level = levels.pick_random()
	var level_scene = selected_level.level_scene.instantiate()
	call_deferred("add_child", level_scene)
	EventBus.loaded_level.emit(selected_level.par)
