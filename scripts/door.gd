extends Node2D

@onready var animated_sprite = $AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.play("close")
	$Label1.hide()
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func _on_area2d_body_entered(body):
	if body.name == "ENUMAN":
		$Label1.show()
		animated_sprite.play("open")

func _on_area2d_body_exited(body):
	if body.name == "ENUMAN":
		$Label1.hide()
		animated_sprite.play("close")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
