extends Node2D

var is_label1_removed: bool = false
var is_label2_removed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label1.hide()
	$Label2.hide()
	$Area2D.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func label1_hide() -> void:
	$Label1.queue_free()
	is_label1_removed = true
func label2_hide() -> void:
	$Label2.queue_free()
	is_label2_removed = true
func _on_area2d_body_entered(body):
	if body.name == "ENUMAN":
		$AnimatedSprite2D.play("opening")
		if is_label1_removed == false && is_label2_removed == true:
			$Label1.show()
		elif is_label1_removed == true && is_label2_removed == false:
			$Label2.show()
		else:
			$Label1.show()
			$Label2.show()
	

func _on_area2d_body_exited(body):
	if body.name == "ENUMAN":
		$AnimatedSprite2D.play("closing")
		if is_label1_removed == false && is_label2_removed == true:
			$Label1.hide()
		elif is_label1_removed == true && is_label2_removed == false:
			$Label2.hide()
		else:
			$Label1.hide()
			$Label2.hide()

func play_animation() -> void:
	$AnimatedSprite2D.play("entering")

func _process(delta: float) -> void:
	pass
