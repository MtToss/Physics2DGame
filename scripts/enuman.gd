extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $Camera2D/Animation/AnimationPlayer
@onready var camera_2D = $Camera2D
@onready var line_edit = $Camera2D/Panel/LineEdit

var correct_answer: int = 42
var user_input: int

func _ready() -> void:
<<<<<<< HEAD
	line_edit.grab_focus()
=======
	
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a
	assert(true, "This line is executed!")

func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jumpspace") and is_on_floor():
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
	if velocity.x != 0:
		animated_sprite.animation = "walk"
	else:
		animated_sprite.animation = "idle"

func adjust_camera(x: float, y: float) -> void:
	var sprite_scale = animated_sprite.scale.length()
	
	var target_zoom = Vector2(x, y) * sprite_scale
	
	camera_2D.zoom = camera_2D.zoom.lerp(target_zoom, 0.1)

<<<<<<< HEAD



func _on_line_edit_text_submitted(new_text: String) -> void:
	print("Entered: ", new_text)
	user_input = int(new_text)
	# Check if the input text matches the correct answer
	if int(new_text) == correct_answer:
	#	correct_answer_submitted.emit()  # Emit signal
		line_edit.text = ""  # Clear input
		print("Debug: Correct answer!")
	else:
		print("Incorrect answer. Try again.")
=======
func resume():
	get_tree().paused = false

func pause():
	get_tree().paused = true
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a
