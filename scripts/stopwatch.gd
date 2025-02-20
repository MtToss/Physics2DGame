extends Node
class_name Stopwatch

var time = 0.0
var stopped = false
var actual_string = '0'

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

func time_to_string() -> String:
	var format_string = "%02d : %02d : %02d"
	if stopped == false: 
		var msec = fmod(time, 1) * 1000
		var sec = fmod(time , 60)
		var min = time / 60
		
		actual_string = format_string % [min, sec, msec]
		return actual_string
	else:
		return actual_string
