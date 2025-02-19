extends Node2D

var speed = 30
var direction = 1
var is_hit = false
var hitting_right: bool = true
func _ready() -> void:
	pass

func change_animation_hit() -> void:
	$Area2D/AnimatedSprite2D.play("hit")
	$Timer.start()

func change_to_visible() -> void:
	$Area2D/AnimatedSprite2D.visible = true
	$Area2D/AnimatedSprite2D.play("shoot")
	is_hit = false

func change_hit_to_false() -> void:
	hitting_right = false

func change_scale_to() -> void:
	$Area2D/AnimatedSprite2D.scale = Vector2(10, 10)
	speed = 500

func _process(delta: float) -> void:
	if !is_hit:
		if hitting_right:
			print("Debug: Flipping into positive x")
			position.x += speed * direction * delta
		else:
			print("Debug: Flipping into negative x")
			position.x -= speed * direction * delta
	else:
		position.x = position.x


func _on_timer_timeout() -> void:
	$Area2D/AnimatedSprite2D.visible = false
