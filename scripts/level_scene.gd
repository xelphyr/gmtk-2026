extends Node2D

const player_scene = preload("res://scenes/player.tscn")

@export var start:Node2D
@export var end:Area2D

signal level_completed()

func _ready():
	end.body_entered.connect(_on_end_body_entered)
	var player = player_scene.instantiate()
	player.global_position = start.global_position
	add_child(player)

func _on_end_body_entered(body: Node2D):
	print("gooby")
	if body.is_in_group("Player"):
		level_completed.emit()
