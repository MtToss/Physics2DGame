extends CharacterBody2D

var speed = 50.0
var JUMP_VELOCITY = -105.0
var multiplier = 7 #will remove this comment after use in the game chapter 1,2,3,4 
var JETPACK_VELOCITY = JUMP_VELOCITY * multiplier
var shooting = false
const GRAVITY = 350.0
const JETPACK_SLOW_DESCENT = 50.0
var is_moving_left: bool = false
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $Camera2D/Animation/AnimationPlayer
@onready var camera_2D = $Camera2D
@onready var line_edit = $Camera2D/Panel/LineEdit
@onready var timer = $Timer

@onready var bullet_scene = preload("res://scenes/bullets.tscn")

signal answer_submitted(user_input: float)

var is_using_jetpack: bool = false
var correct_answer: int = 42
var user_input: int

func _ready() -> void:
	line_edit.grab_focus()

func _process(delta: float) -> void:
	
	pass
func _physics_process(delta: float) -> void:
	if not is_on_floor() and not is_using_jetpack:
		velocity.y += GRAVITY * delta

	if is_using_jetpack and not is_on_floor():
		velocity.y = lerp(velocity.y, JETPACK_SLOW_DESCENT, 0.1)

	if is_on_floor():
		is_using_jetpack = false


	if Input.is_action_just_pressed("jumpspace") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("skill") and is_on_floor():
		is_using_jetpack = true
		velocity.y = JETPACK_VELOCITY
		animated_sprite.animation = "jetpack_jump"

	var direction := Input.get_axis("backward", "forward")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	
	if is_on_ceiling():
		velocity.y = 0
	
	if is_on_wall():
		velocity.x = 0 
	
	dynamic_animation()
	flip_body()


func flip_body() -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = true  
	elif velocity.x:
		animated_sprite.flip_h = false 

func dynamic_animation() -> void:
	if not is_on_floor() && shooting == false:
		if is_using_jetpack:
			if velocity.y < 0:
				animated_sprite.animation = "jetpack_jump"  
			else:
				animated_sprite.animation = "jetpack_fall"
		else:
			if velocity.y < 0:
				animated_sprite.animation = "jump"
			else: 
				animated_sprite.animation = "fall"
	elif velocity.x != 0 && shooting == false:
		animated_sprite.animation = "walk"  
	elif velocity.x == 0 && shooting == false:
		animated_sprite.animation = "idle" 

func adjust_camera(x: float, y: float) -> void:
	var sprite_scale = animated_sprite.scale.length()
	
	var target_zoom = Vector2(x, y) * sprite_scale
	
	camera_2D.zoom = camera_2D.zoom.lerp(target_zoom, 0.1)

func change_animation_to_shoot() -> void:
	timer.start()
	speed = 0
	shooting = true
	animated_sprite.animation = "shoot" 

func _on_line_edit_text_submitted(new_text: String) -> void:
	print("Entered: ", new_text)
	user_input = new_text.to_float()

	var decision: bool = (user_input == correct_answer)
	emit_signal("answer_submitted", user_input)
	print("Debug: Signal emitted with value ", user_input)
	
	if decision:
		line_edit.text = "" 
		print("Debug: korique")
	else:
		print("Incorrect answer. Try again.")


func _on_timer_timeout() -> void:
	shooting = false
	if animated_sprite.flip_h == true:
		is_moving_left = true
	elif animated_sprite.flip_h == false:
		is_moving_left = false
