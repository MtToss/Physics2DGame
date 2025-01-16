extends Area2D

var is_chest_opened = false
@onready var animation_player = $Camera2D/Animation/AnimationPlayer


func _ready() -> void:
	$Label.hide()

	self.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	self.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func _on_area2d_body_entered(body):
	if body.name == "ENUMAN":
		if is_chest_opened:
			$Label.hide()
			
		else:
			$Label.show()

		print("Debug: ENUMAN entered the chest 2D area mosshing!")

func _on_area2d_body_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the chest 2D area mosshing!")
		$Label.hide()

func _open_chest():
	$AnimatedSprite2D.play("opened chest") 
	
	is_chest_opened = true
	$Label.hide
	print("The chest is opening!")

	
