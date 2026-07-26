extends Node

const menu_scene = preload("res://scenes/menu.tscn")
const countdown_scene = preload("res://scenes/countdown.tscn")
const game_scene = preload("res://scenes/game.tscn")
const end_scene = preload("res://scenes/end_scene.tscn")

const level_point = 100
const par_points = 50

var start_time = 120.0
var time: float
var par: float

var levels_completed = 0
var levels_par = 0

enum GameState {
	MENU,
	COUNTDOWN,
	GAME,
	END,
}

var game_state : GameState = GameState.MENU :
	set(val):
		_on_state_change(val)
		game_state = val;



func _on_state_change(state:GameState):
	match state:
		GameState.MENU:
			levels_completed = 0
			levels_par = 0
			get_tree().change_scene_to_packed(menu_scene)
			AudioManager.clear_audio()
			AudioManager.call_deferred("create_audio", SoundEffectSettings.SoundEffectType.MENU_MUSIC)

		GameState.COUNTDOWN:
			get_tree().change_scene_to_packed(countdown_scene)
			AudioManager.clear_audio()
			AudioManager.call_deferred("create_audio", SoundEffectSettings.SoundEffectType.MUSIC)
			await get_tree().create_timer((60.0/172.0) * 4.0).timeout
			game_state = GameState.GAME
		GameState.GAME:
			get_tree().change_scene_to_packed(game_scene)
			time = start_time
			await get_tree().scene_changed
			call_deferred("_start_load")
		GameState.END:
			AudioManager.clear_audio()
			get_tree().change_scene_to_packed(end_scene)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)
	EventBus.loaded_level.connect(_on_loaded_level)

	AudioManager.call_deferred("create_audio", SoundEffectSettings.SoundEffectType.MENU_MUSIC)

	time = start_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_state == GameState.GAME:
		_dec_time(delta)

func _dec_time(delta: float):
	time -= delta
	par -= delta

	if time < 0.0:
		game_state = GameState.END
		return

	EventBus.time_update.emit(time, par)

func _on_loaded_level(level_par: float):
	par = level_par

func _on_level_completed():
	if par >=0.0:
		time += par
		levels_par += 1
	levels_completed += 1

func _start_load():
	EventBus.request_load_level.emit()
