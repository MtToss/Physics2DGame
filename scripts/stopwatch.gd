extends Node
class_name Stopwatch

var time = 0.0
var stopped = false
var actual_string = "00:00"

func _process(delta: float) -> void:
	if stopped: 
		return
	time += delta

func reset():
	time = 0.0
	stopped = false  

func stop():
	stopped = true 

func resume():
	stopped = false  

func get_time() -> Dictionary:
	var sec = fmod(time, 60) as int
	var min = (time / 60) as int
	return {
		"seconds": sec,
		"minutes": min
	}

func time_to_string() -> String:
	var sec = fmod(time, 60) as int
	var min = (time / 60) as int
	actual_string = "%02d:%02d" % [min, sec]
	return actual_string
