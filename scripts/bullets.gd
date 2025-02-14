extends Node2D

var speed = 30
var direction = 1
var is_hit = false
var hitting_right: bool = true
func _ready() -> void:
	pass

func change_animation_hit() -> void:
	$Area2D/AnimatedSprite2D.play("hit")

func change_hit_to_false() -> void:

	hitting_right = false
	
func _process(delta: float) -> void:
	if !is_hit:
		if hitting_right:
			position.x += speed * direction * delta
		else:
			position.x -= speed * direction * delta
	else:
		position.x = position.x
	
