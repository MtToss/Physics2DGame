extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $AnimatedSprite2D/Timer

@onready var bullet_scene = preload("res://scenes/benson_projectile.tscn") 
var hp: int = 300
var hit_dmg: int = 10

var is_play: bool = true

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	timer.start()

func hitted() -> void:
	if(hp > 0):
		hp = hp - 7 #naging constant yung damage pero babaguhin since may bulldog pa
	else: 
		change_animation_to_dead()
func change_animation_to_dead() -> void:
	pass


func _on_timer_timeout() -> void:
	if(is_play == true):
		animated_sprite.play("laugh")
		is_play = false
		timer.start()
	else:
		animated_sprite.play("default")
		is_play = true
		timer.start()
