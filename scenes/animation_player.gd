extends AnimationPlayer

@export var slide_duration: float = 3.0 
var time_elapsed: float = 0.0
var is_sliding: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func play_slide() -> void:
	play("slide")
	is_sliding = true
	time_elapsed = 0.0
	print("Debug: the slide is running")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_sliding:
		time_elapsed += delta
		if time_elapsed >= slide_duration:
			play("slide out")
			print("Debug: the slide out is running")
			is_sliding = false
