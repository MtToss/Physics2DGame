extends CharacterBody2D

var is_dead: bool = false
@onready var bullet_scene = preload("res://scenes/bullets.tscn") # Load bullet scene
var is_moving_left = false

var gravity = 10
var speed = 7 

func change_animation_to_shoot():
	$AnimatedSprite2D.play("shot")
	speed = 0
	
func change_animation_to_walk():
	$AnimatedSprite2D.play("walk")

func change_animation_to_dead():
	is_dead = true
	$AnimatedSprite2D.play("dead")
	$Area2D.queue_free()
	$CollisionShape2D.queue_free()
	speed = 0


func verify_dead() -> void:
	if($AnimatedSprite2D.animation != "dead" and is_dead == true):
		$AnimatedSprite2D.play("dead")
		speed = 0

func _ready():
	up_direction = Vector2.UP  

func _process(_delta):
	
	verify_dead()
	move_character()
	detect_turn_around()
		
func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	move_and_slide() 
	

func detect_turn_around():
	if is_dead == false:
		if not $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
			is_moving_left = !is_moving_left
			scale.x = -scale.x
