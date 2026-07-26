extends Control

const speed = 172.0

var index: int = 3:
	set(val):
		index=val
		update_text(val)

@onready var cooldown = 60.0/speed

func _process(delta: float) -> void:
	cooldown -= delta
	if cooldown < 0:
		index -= 1
		cooldown = 60.0/speed

func update_text(val:int):
	if val>0:
		$"PanelContainer/Label".text = str(val)
	else:
		$AnimationPlayer.play("Go")
