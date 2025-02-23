extends Node2D

var speed = 30
var direction = 1
var is_hit = false
var hitting_right: bool = true

func _ready() -> void:
	$Area2D/AnimatedSprite2D.flip_h = true
	

func change_animation_hit() -> void:
	$Area2D/AnimatedSprite2D.visible = false

func change_to_visible() -> void:
	$Area2D/AnimatedSprite2D.visible = true
	$Area2D/AnimatedSprite2D.play("shoot")
	is_hit = false

func change_hit_to_false() -> void:
	hitting_right = false

func change_scale_to(x: int, y: int) -> void:
	$Area2D/AnimatedSprite2D.scale = Vector2(x, y)
	speed = 500

func _process(delta: float) -> void:
	if !is_hit:
		if hitting_right:
			position.x += speed * direction * delta

		else:
			position.x -= speed * direction * delta

	else:
		position.x = position.x
