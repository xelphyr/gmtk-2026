extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.call_deferred("create_audio", SoundEffectSettings.SoundEffectType.END)
	call_deferred("_display")

func _display():
	var levels_completed = GameManager.levels_completed
	var levels_par = GameManager.levels_par
	var level_points = levels_completed*GameManager.level_point
	var par_points = levels_par*GameManager.par_points
	var total = level_points + par_points



	$"P/V/G/LCNum".text = str(levels_completed)
	$"P/V/G/LCPoints".text = str(level_points)
	$"P/V/G/LPNum".text = str(levels_par)
	$"P/V/G/LPPoints".text = str(par_points)
	$"P/V/G/Total".text = str(total)
