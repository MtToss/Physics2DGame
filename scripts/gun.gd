extends CharacterBody2D


@onready var bullet_scene = preload("res://scenes/bullets.tscn") # Load bullet scene
var is_moving_left = false

var gravity = 10
var speed = 7 

func change_animation_to_shoot():
	$AnimatedSprite2D.play("shot")
	
func change_animation_to_walk():
	$AnimatedSprite2D.play("walk")

func _ready():
	up_direction = Vector2.UP  

func _process(_delta):
	move_character()
	detect_turn_around()
		
func move_character():
	velocity.x = -speed if is_moving_left else speed
	velocity.y += gravity
	move_and_slide() 
	

func detect_turn_around():
	if not $RayCast2D.is_colliding():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
