extends Node2D

@onready var enuman = $Character_Handler/ENUMAN
@onready var camera = $Character_Handler/ENUMAN/Camera2D

@onready var gun_enuman = $Character_Handler/ENUMAN
@onready var fire_timer_enuman = $FireTimerEnuman

@onready var collision_shape = $Character_Handler/ENUMAN/CollisionShape2D

@onready var benson = $Benson


@onready var gun_benson = $Benson
@onready var fire_timer_benson = $FireTimerBenson

var new_bullet_benson
var bullet_collision_benson
var new_bullet_enuman
var bullet_collision_enuman

var hp: int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.enabled = false 
	
	collision_shape.global_position = enuman.global_position
	
	enuman.speed = 300
	enuman.JUMP_VELOCITY = -275
	
	new_bullet_enuman = gun_enuman.bullet_scene.instantiate()
	new_bullet_benson = gun_benson.bullet_scene.instantiate()
	
	fire_timer_benson.start()
	
	bullet_collision_benson = new_bullet_benson.get_node("Area2D")
	bullet_collision_benson.connect("body_entered", Callable(self, "_on_bullet_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: 
	firing()

func _on_bullet_entered_hallwayman(body):
	print("Debug: it satisfies", body.name)
	if body.name == "Benson":
		print("Debug: natamaan si benson")
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
		benson.hp = benson.hp - enuman.hit_dmg
		print("Debug: Benson's hp", benson.hp)
		if(benson.hp <= 75):  # dagdagan mo ng and operator
			print("Debug: 1/4 hp")
		elif(benson.hp <= 150): 
			print("Debug: 2/4 hp")
		elif(benson.hp <= 225): 
			print("Debug: 3/4 hp")
		elif(benson.hp <=300): 
			print("Debug: 4/4 hp")
		else:
			print("Game Over")

func _on_bullet_entered(body):
	print("satisfied: ", body.get_parent())
	if body.name == "ENUMAN":
		print("Debug: namatay")
		new_bullet_benson.change_animation_hit()
		new_bullet_benson.is_hit = true
		enuman.hp = enuman.hp - benson.hit_dmg
		print("Debug: HP of enuman: ", enuman.hp)
		if(enuman.hp <= 25): 
			print("Debug: 1/4 hp")
		elif(enuman.hp <= 50): 
			print("Debug: 2/4 hp")
		elif(enuman.hp <= 75): 
			print("Debug: 3/4 hp")
		elif(enuman.hp <= 100): 
			print("Debug: 4/4 hp")
		else:
			print("Game Over")

		
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
