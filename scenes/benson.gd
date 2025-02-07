extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $AnimatedSprite2D/Timer

var is_play = true
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	timer.start()
	


func _on_timer_timeout() -> void:
	if(is_play == true):
		print("Debug: Playing Laugh")
		animated_sprite.play("laugh")
		is_play = false
		timer.start()
	else:
		print("Debug: Playing Default Animation")
		animated_sprite.play("default")
		is_play = true
		timer.start()
