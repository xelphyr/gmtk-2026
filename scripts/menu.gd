extends Control

@onready var help : PopupPanel = $"Popup"

func _on_help_pressed():
	help.popup_centered()
