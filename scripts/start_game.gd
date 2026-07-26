extends Button


func _on_pressed():
	GameManager.game_state = GameManager.GameState.COUNTDOWN
