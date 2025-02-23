extends Node2D

@onready var animation_activator_3000 = $Area2D2
@onready var portal_area = $Area2D

var scene
var num_identifier: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("close")
	animation_activator_3000.connect("body_entered", Callable(self, "on_area2d_animation_enter"))
	animation_activator_3000.connect("body_exited", Callable(self, "on_area2d_animation_exit"))
	portal_area.connect("body_entered", Callable(self, "on_area2d_portal_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_area2d_animation_enter(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		$AnimatedSprite2D.play("open")
		print("Debug: entered area 2d")

func on_area2d_animation_exit(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		$AnimatedSprite2D.play("close")

func on_area2d_portal_entered(body):
	print("Debug: scene", scene)
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		
		match(num_identifier):
			1:
				get_tree().change_scene_to_file("res://scenes/game_chapter_2.tscn")
			2: 
				get_tree().change_scene_to_file("res://scenes/game_chapter_3.tscn")
			3:
				get_tree().change_scene_to_file("res://scenes/game_chapter_4.tscn")
			4:
				get_tree().change_scene_to_file("res://scenes/2-Player/game_chapter_2.tscn")
			5:
				get_tree().change_scene_to_file("res://scenes/2-Player/game_chapter_3.tscn")
			6:
				get_tree().change_scene_to_file("res://scenes/2-Player/game_chapter_4.tscn")
		print("Debug: entered")
