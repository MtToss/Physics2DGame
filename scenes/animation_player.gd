extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func play_slide() -> void:
	print("RUNNING")
	play("slide")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
