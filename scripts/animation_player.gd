extends AnimationPlayer

@export var slide_duration: float = 3.0 
var time_elapsed: float = 0.0
var is_sliding: bool = false
var current = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func play_slide() -> void:
	play("slide")
	current = 1
	is_sliding = true
	time_elapsed = 0.0
	print("Debug: slide")

func play_slide_part_2() -> void:
	play("slide_part2")
	current = 2
	is_sliding = true
	time_elapsed = 0.0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_sliding:
		time_elapsed += delta
		if time_elapsed >= slide_duration and current == 1:
			play("slide out")
			is_sliding = false
		
		elif time_elapsed >= slide_duration and current == 2: 
			play("slide_out_part2")
			is_sliding = false
