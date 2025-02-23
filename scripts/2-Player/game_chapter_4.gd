extends Node2D


@export var burst_count: int = 5  # Number of projectiles in the burst
@export var burst_spread: float = 45.0  # Spread angle in degrees
@export var special_skill_cooldown: float = 10.0  # Cooldown in seconds

@onready var special_skill_timer_benson: Timer = $SpecialSkillTimerBenson

@onready var enuman = $Character_Handler/ENUMAN
@onready var camera = $Character_Handler/ENUMAN/Camera2D

@onready var gun_enuman = $Character_Handler/ENUMAN
@onready var fire_timer_enuman = $FireTimerEnuman

@onready var collision_shape = $Character_Handler/ENUMAN/CollisionShape2D

@onready var benson = $Benson

@onready var dog = $Character_Handler/Doggi

@onready var gun_benson = $Benson
@onready var fire_timer_benson = $FireTimerBenson

@onready var heart = $CanvasLayer/HBoxContainer/heart
@onready var heart2 = $CanvasLayer/HBoxContainer/heart2
@onready var heart3 = $CanvasLayer/HBoxContainer/heart3
@onready var heart4 = $CanvasLayer/HBoxContainer/heart4

@onready var container = $Character_Handler/ENUMAN/Camera2D2/HBoxContainer

@onready var phantomchu = $Camera2D/PhantomCameraHost
@onready var form_book = $CanvasLayer/formula_book
@onready var manual_pause = $CanvasLayer/pause_menu
@onready var act_stopwatch = $Stopwatch
@onready var dialogue_data = $CanvasLayer/dialogue

var new_bullet_benson
var bullet_collision_benson
var new_bullet_enuman
var bullet_collision_enuman

var hp: int = 100
var empty_heart = [
	{"image": preload("res://assets/assets/empty_heart.png")},
]
var full_heart = [
	{"image": preload("res://assets/assets/hearts.png")},
]

@onready var pcam = $Character_Handler/PhantomCamera2D
@onready var doggi_area2D = $Character_Handler/Doggi/Area2D2

var target_enuman = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pcam.set_zoom(Vector2(50,50))
	pcam.set_auto_zoom_max(1)
	pcam.set_auto_zoom(true)
	pcam.set_auto_zoom_margin(Vector4(70, 30, 40, 70))
	doggi_area2D.connect("body_entered", Callable(self,"when_hallwayman_hit"))
	
	
	camera.enabled = false 
	
	collision_shape.global_position = enuman.global_position
	
	enuman.speed = 300
	enuman.JUMP_VELOCITY = -275
	dog.speed = 325
	dog.JUMP_VELOCITY = -375
	
	new_bullet_enuman = enuman.bullet_scene.instantiate()
	new_bullet_benson = benson.bullet_scene.instantiate()
	
	fire_timer_benson.start()
	
	bullet_collision_benson = new_bullet_benson.get_node("Area2D")
	bullet_collision_benson.connect("body_entered", Callable(self, "_on_bullet_entered"))
	
func hideorshow_panels():
	if form_book.visible == true and manual_pause.visible == false:
		form_book.visible = false
		manual_pause.visible = true
	elif form_book.visible == false and manual_pause.visible == true:
		form_book.visible = true
		manual_pause.visible = false



func pause_by_pause_menu():
	act_stopwatch.process_mode = Node.PROCESS_MODE_PAUSABLE

func pause_by_formula_button():
	act_stopwatch.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack_dog"):
		dog.change_animation_to_attack()
		
	
	if event.is_action_pressed("skill_dog"):
		dog.change_animation_to_shield()

func _process(delta: float) -> void: 
	firing()
	if target_enuman != null:
		var direction = (target_enuman.global_position - new_bullet_benson.global_position).normalized()
		var speed = 200 
		new_bullet_benson.global_position += direction * speed * delta



func _on_bullet_entered_hallwayman(body):
	print("Debug: it satisfies", body.name)
	if body.name == "Benson":
		print("Debug: natamaan si benson")
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
		benson.hp = benson.hp - enuman.hit_dmg
		print("Debug: Benson's hp", benson.hp)
		
		if(benson.hp <= 75) and (benson.hp <= 1):  # dagdagan mo ng and operator
			print("Debug: 1/4 hp")
		elif(benson.hp <= 150) and (benson.hp <= 76): 
			print("Debug: 2/4 hp")
		elif(benson.hp <= 225) and (benson.hp <= 151): 
			print("Debug: 3/4 hp")
		elif(benson.hp <=300) and (benson.hp <= 226): 
			print("Debug: 4/4 hp")
		else:
			print("Game Over")

func _on_bullet_entered(body):
	print("satisfied: ", body.name)
	if body.name == "ENUMAN" or body.name == "Doggi":
		print("Debug: namatay")
		new_bullet_benson.change_animation_hit()
		new_bullet_benson.is_hit = true
		enuman.hp = enuman.hp - benson.hit_dmg
		print("Debug: HP of enuman: ", enuman.hp)
		if(enuman.hp <= 25) and (enuman.hp >= 1): 
			print("Debug: 1/4 hp")
			heart2.texture = empty_heart[0]["image"]  # Change last heart to empty
		elif(enuman.hp <= 50) and (enuman.hp >= 26): 
			print("Debug: 2/4 hp")
			heart3.texture = empty_heart[0]["image"]  # Change last heart to empty
		elif(enuman.hp <= 75) and (enuman.hp >= 51): 
			print("Debug: 3/4 hp")
			heart4.texture = empty_heart[0]["image"]  # Change last heart to empty
		elif(enuman.hp <= 100 ) and (enuman.hp >= 76): 
			print("Debug: 4/4 hp")
		else:
			print("Game Over")
			heart.texture = empty_heart[0]["image"]  # Change last heart to empty

		
	elif body.get_parent() != null && body.name != "Benson": 
		print("Debug: Collided")
		new_bullet_benson.change_animation_hit()
		new_bullet_benson.is_hit = true

func firing() -> void:
	if(Input.is_action_just_pressed("fire")):
		fire_timer_enuman.start()
		enuman.change_animation_to_shoot()
		await fire_timer_enuman.timeout
		enuman.speed = 300

func _on_fire_timer_enuman_timeout() -> void:
		new_bullet_enuman.change_to_visible()
		new_bullet_enuman.change_scale_to()
		new_bullet_enuman.hitting_right = !enuman.is_moving_left
		add_child(new_bullet_enuman)
		new_bullet_enuman.global_position = enuman.get_global_transform().origin + Vector2(6, -4.9)
		bullet_collision_enuman = new_bullet_enuman.get_node("Area2D")
		bullet_collision_enuman.connect("body_entered", Callable(self, "_on_bullet_entered_hallwayman"))


func _on_fire_timer_benson_timeout() -> void:
		fire_timer_benson.start()
		
		new_bullet_benson.change_scale_to(3,3)
		new_bullet_benson.hitting_right = false
		print("Debug: ", new_bullet_benson)
		print("Debug: Position: ", new_bullet_benson.global_position)
		add_child(new_bullet_benson)
		new_bullet_benson.global_position = benson.get_global_transform().origin + Vector2(0,0)	
		new_bullet_benson.change_to_visible()
		
		target_enuman = enuman
