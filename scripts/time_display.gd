extends Node

@export var time_display: Label
@export var ms_display: Label
@export var par_display: Label
@export var par_ms_display: Label

func _ready():
	EventBus.time_update.connect(_on_time_update)


func _on_time_update(time:float, par:float):
	var time_arr = _num_to_time(time)

	time_display.text = "%02.f:%02d" % [time_arr[0], time_arr[1]]
	ms_display.text = "%02.f" % time_arr[2]

	var par_arr = _num_to_time(par)

	par_display.text = ("{0}%02.f:%02d" % [par_arr[0], par_arr[1]]).format(["+" if par>0 else "-"])
	par_ms_display.text = "%02.f" % par_arr[2]

func _num_to_time(num) -> Array[float]:
	var time: Array[float] = []

	time.append(_rtz(num/60.0))
	time.append(abs(_rtz(num)%60))
	time.append(abs(snapped((num - _rtz(num))*100, 1)))

	return time

## round to zero
func _rtz(num: float) -> int:
	if num>0:
		return int(floor(num))
	else:
		return int(ceil(num))
