extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -200.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $Camera2D/Animation/AnimationPlayer

func _ready() -> void:
	print(animation_player)
	assert(true, "This line is executed!")
	#animation_player.play_slide()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("backward", "forward")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	dynamic_animation()
	flip_body()
	move_and_slide()
	
		
func flip_body() -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = true  

	elif velocity.x > 0:
		animated_sprite.flip_h = false 
		
func dynamic_animation() -> void:
		# Set the animation na naka base sa movement ng sprite
	if velocity.x != 0:
		animated_sprite.animation = "walk"
	else:
		animated_sprite.animation = "idle"
