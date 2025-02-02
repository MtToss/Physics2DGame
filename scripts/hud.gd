extends Control
class_name HUD

@export var stopwatch_label: Label

var stopwatch : Stopwatch #this is where the stopwatch at

func _ready() -> void:
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
func  _process(delta: float) -> void:
	update_stopwatch_label()
	
func update_stopwatch_label():
	stopwatch_label.text = stopwatch.time_to_string()

func stop() -> void:
	print("Debug: Nagreresume")
	stopwatch.stop()

func play() -> void:
	print("Debug: Nagpopause")
	stopwatch.resume()
