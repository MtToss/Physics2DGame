extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func disable_collision():
	$CollisionShape2D.disabled = true

func _on_area2d_body_entered(body):
	if body.name == "ENUMAN":
		$Label.hide()
		print("Debug: ENUMAN entered the pressure plate mosshing")
	
func _on_area2d_body_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the chest 2D area mosshing!")
		$Label.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
