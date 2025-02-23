extends CharacterBody2D

var speed = 75.0
var JUMP_VELOCITY = -255.0
var attacking = false
@onready var animated_sprite = $AnimatedSprite2D
var hit_dmg = 7

@onready var animated_sprite_shield = $StaticBody2D/AnimatedSprite2D

@onready var bite_collision_shape = $Area2D2/Bite_Collision_Shape
@onready var shield_collision_shape = $StaticBody2D/Shield_Collision_Shape

var is_shield_available = true

func _ready() -> void:
	shield_collision_shape.disabled = true
	animated_sprite_shield.global_position = global_position + Vector2(0.2,-2)
	bite_collision_shape.disabled = true
func _physics_process(delta: float) -> void:
	if !is_shield_available:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump_dog") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("backward_dog", "forward_dog")
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
		bite_collision_shape.global_position = global_position + Vector2(-3,1)
		shield_collision_shape.global_position = global_position + Vector2(-3,-2)
		animated_sprite_shield.flip_h = true
		animated_sprite_shield.global_position = global_position + Vector2(-0.2,-2)

	elif velocity.x:
		animated_sprite.flip_h = false 
		bite_collision_shape.global_position = global_position + Vector2(3,1)
		shield_collision_shape.global_position = global_position + Vector2(3,-2)
		animated_sprite_shield.flip_h = false
		animated_sprite_shield.global_position = global_position + Vector2(0.2,-2)


func dynamic_animation() -> void:

	if velocity.y < 0:
		animated_sprite.animation = "jump"
	elif velocity.x != 0 and attacking == false:
		animated_sprite.animation = "run"  
	elif velocity.x == 0 and attacking == false:
		animated_sprite.animation = "idle" 


func change_animation_to_attack() -> void:
	$Timer.start()
	attacking = true
	bite_collision_shape.disabled = false
	animated_sprite.animation = "attack"

func change_speed() -> void:
	speed = 250
func change_animation_to_shield() -> void:
	if is_shield_available:
		$ShieldTimer.start()
		animated_sprite_shield.animation = "shield"
		shield_collision_shape.disabled = false
		is_shield_available = false
		
		velocity.x = 0
	else:
		print("Debug: Skill on cooldown")

func _on_timer_timeout() -> void:
	attacking = false
	bite_collision_shape.disabled = true

func _on_shield_timer_timeout() -> void:
	animated_sprite_shield.animation = "off"
	shield_collision_shape.disabled = true
	is_shield_available = true
