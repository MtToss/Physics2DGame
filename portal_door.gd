extends Node2D

@onready var animation_activator_3000 = $Area2D2
@onready var portal_area = $Area2D

var scene_path = "res://scenes/game_chapter_2.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("close")
	animation_activator_3000.connect("body_entered", Callable(self, "on_area2d_animation_enter"))
	animation_activator_3000.connect("body_exited", Callable(self, "on_area2d_animation_exit"))
	portal_area.connect("area_entered", Callable(self, "on_area2d_portal_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_area2d_animation_enter(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		$AnimatedSprite2D.play("open")

func on_area2d_animation_exit(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		$AnimatedSprite2D.play("close")

func on_area2d_portal_entered(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		get_tree().change_scene_to_file(scene_path)
		print("Debug: entered")
