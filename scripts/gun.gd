extends CharacterBody2D

@onready var timer = $AnimatedSprite2D/Timer
var bullet_path = preload("res://scenes/bullets.tscn")

var is_fire_paused = true

func _process(delta: float) -> void:
	pass

func fire():
	_on_timer_timeout()


func _on_timer_timeout() -> void:
	if(is_fire_paused):
		timer.start()
		var bullet = bullet_path.instantiate()
		bullet.direction = -1
		add_child(bullet)

func decision_to_pause(choice: bool) -> void:
	is_fire_paused = choice
