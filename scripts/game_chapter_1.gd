extends Node2D
# game chapter 1
@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label
@onready var label3 = $chest3/Area2D/Label
@onready var label4 = $chest4/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D
@onready var chest3 = $chest3/Area2D
@onready var chest4 = $chest4/Area2D

@onready var chest1animation = $chest1

@onready var character_animation_sprite_2D = $ENUMAN/AnimatedSprite2D

@onready var animation_player = $ENUMAN/Camera2D/Animation/AnimationPlayer
@onready var animation_label = $ENUMAN/Camera2D/Animation/Control/Label

@onready var animation_control = $ENUMAN/Camera2D/Animation/Control

@onready var prompt_panel = $ENUMAN/Camera2D/Panel
@onready var dialogue_panel = $ENUMAN/Camera2D/Panel2
@onready var dialogue_label = $ENUMAN/Camera2D/Panel2/Dialogue

@onready var prompt_label1 = $ENUMAN/Camera2D/Panel/Label1
@onready var prompt_label2 = $ENUMAN/Camera2D/Panel/Label2
@onready var prompt_label3 = $ENUMAN/Camera2D/Panel/Label3
@onready var prompt_label4 = $ENUMAN/Camera2D/Panel/Label4
@onready var prompt_label5 = $ENUMAN/Camera2D/Panel/Label5


@onready var pressure_plate1 = $pressure_plate1/Area2D

@onready var stopwatch = $CanvasLayer/Hud 

@onready var camera = $ENUMAN

<<<<<<< HEAD
@onready var answer = $ENUMAN

@onready var hallwayman = $HallwayMan/CharacterBody2D
@onready var hallwayman_area_2D = $HallwayMan/CharacterBody2D/Area2D

@onready var hallway_bullet = $HallwayMan/CharacterBody2D/CollisionShape2D2
=======
<<<<<<< HEAD

=======
@onready var hallwayman = $HallwayMan/CharacterBody2D
@onready var hallwayman_area_2D = $HallwayMan/CharacterBody2D/Area2D

#var is_fire_paused = true
>>>>>>> 764ec59febe39b50328ea4437107ebb11d61b38c
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a

@onready var gun = $HallwayMan/CharacterBody2D
@onready var fire_timer = $FireTimer

@onready var line_edit = $ENUMAN/Camera2D/Panel/LineEdit


var correct_answer = 0

var bullet_scene
var bullet_collision
var is_fire_paused = true
var is_paused = false
var prompt_label_list = []

var given_problem1 = ["Velocity", "Angle", "Time of Flight", "Max Height", "Range"]
var problem_value1 = [null, null, null, null, null]
var get_value1 = [null, null, null, null, null]
var get_given_value1 = [null, null, null, null, null]
var available_indices = []
<<<<<<< HEAD

var dialogue = [
		"The possibilities are endless. The world is your canvas, waiting for your brushstrokes of imagination to breathe life into it.",
		"From the depths of the ocean to the vastness of space, there are stories to be told and adventures to be had. ",
		" Take a leap of faith into the unknown, for it is there that the magic happens. ",
		"Embrace the uncertainty, the challenges, and the beauty that lies within every step of the journey. So, go forth, and create your own masterpiece."
	]

var index = 0  # Tracks the current line
var typing_speed = 0.0005  # Adjust typing speed (seconds per character)
var is_typing = false  # Prevent skipping during typing


=======
>>>>>>> 764ec59febe39b50328ea4437107ebb11d61b38c
var gravity = 9.8

var new_bullet

func randomize_problem_values() -> void:
	var velocity = (randi() % 100) + 30  
	var angle = (randi() % 60) + 30      

	var time_of_flight = (2 * velocity * sin(deg_to_rad(angle))) / gravity
	var max_height = (velocity * velocity * sin(deg_to_rad(angle)) * sin(deg_to_rad(angle))) / (2 * gravity)
	var range = (velocity * velocity * sin(2 * deg_to_rad(angle))) / gravity

	problem_value1 = [velocity, angle, time_of_flight, max_height, range]

	print("Debug: Velocity is %s" % [velocity])
	print("Debug: Angle is %s" % [angle])
	print("Debug: Time of Flight is %s" % [time_of_flight])
	print("Debug: Max Height is %s" % [max_height])
	print("Debug: Range is %s" % [range])

func _ready() -> void:
	

	
	
	
	print('Debug: ito po ang gumagana game_chapter_1.gd/script')
	randomize_problem_values()
	available_indices = range(given_problem1.size())


	prompt_label_list = [prompt_label1, prompt_label2, prompt_label3, prompt_label4, prompt_label5]

	pressure_plate1.connect("body_entered", Callable(self, "_on_pressure_plate_entered"))
	pressure_plate1.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))
<<<<<<< HEAD
	
	hallwayman_area_2D.connect("body_entered", Callable(self, "_on_hallway_enemy_entered"))
	hallwayman_area_2D.connect("body_exited", Callable(self,"_on_hallway_enemy_exited"))
	line_edit.text_submitted.connect($ENUMAN._on_line_edit_text_submitted)
	

func _on_bullet_entered(body):
	if body.name == "ENUMAN":
		fire_timer.stop()
		new_bullet.change_animation_hit()
		new_bullet.is_hit = true
		print("napatay siya")

func game_over_panel():
	print("game over")

func _on_bullet_exited(body):
	if body.name == "ENUMAN":
		print("tumagos gago!")
=======
<<<<<<< HEAD
	show_dialogue_panel()
	
	
=======
	hallwayman_area_2D.connect("body_entered", Callable(self, "_on_hallway_enemy_entered"))
	hallwayman_area_2D.connect("body_exited", Callable(self,"_on_hallway_enemy_exited"))
>>>>>>> 764ec59febe39b50328ea4437107ebb11d61b38c
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a

func _on_hallway_enemy_entered(body):
	if body.name == "ENUMAN":
		is_fire_paused = false
		hallwayman.change_animation_to_shoot()
		hallwayman.speed = 0
		
		print("Debug: ENUMAN entered Hallway man body")
		get_bullet_collision()

func _on_hallway_enemy_exited(body):
	if body.name == "ENUMAN":
		is_fire_paused = true
		hallwayman.speed = 7
		hallwayman.change_animation_to_walk()
		print("Debug: ENUMAN Exited Hallway man body")
		get_bullet_collision()

func get_bullet_collision():
	fire_timer.start()

func _on_pressure_plate_entered(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN stepped on the pressure plate!")
		open_panel()
		perform_calculations()

func pop_main_menu() -> void:
	if Input.is_action_just_pressed("escape"):
		is_paused = !is_paused
<<<<<<< HEAD
		if is_paused:
			stopwatch.stop() 
			character_animation_sprite_2D.stop()
			chest1.stop()
			print("Debug: Game Paused")
		else:
			stopwatch.play()
			character_animation_sprite_2D.play()
			chest1.play()
			print("Debug: Game Resumed")


func change_of_hitting() -> void:
	if(gun.is_moving_left == true && new_bullet.hitting_right == true):
		new_bullet.hitting_right = false
	else:
		new_bullet.hitting_right = true

=======
		get_tree().paused = is_paused
			
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a
func _on_pressure_plate_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the pressure plate!")
		close_panel()

func insremove(random_index: int) -> void:
	if get_value1[random_index] == null:
		get_value1.remove_at(random_index)
		get_value1.insert(random_index, problem_value1[random_index])
		get_given_value1.remove_at(random_index)
		get_given_value1.insert(random_index, given_problem1[random_index])

func open_panel() -> void:
	print("Debug: Open_panel opened")
	prompt_panel.set_visible(true)
	line_edit.grab_focus()
	for index in range(given_problem1.size()):
		if get_value1[index] == null:
			prompt_label_list[index].text = "?"
			print("Missing value for: %s" % [given_problem1[index]])
		else:
			prompt_label_list[index].text = "%s: %s" % [given_problem1[index], get_value1[index]]
	print("Debug: Is it editable", line_edit.editable)

func close_panel() -> void:
	prompt_panel.set_visible(false)
	print("Debug: Panel is now closed")

<<<<<<< HEAD
=======
func show_dialogue_panel() -> void:
	print("Debug: dialogue_panel opened")
	dialogue_panel.set_visible(true)
	dialogue_label.text = ""  # Clear text before showing dialogue

func close_dialogue_panel() -> void:
	dialogue_panel.set_visible(false)
	print("Debug: Dialogue Panel is now closed")

func show_typing_effect(text: String, speed: float) -> void:
	is_typing = true  # Set typing flag to true
	dialogue_label.text = ""  # Clear label before typing
	for i in range(text.length()):
		dialogue_label.text += text[i]
		await get_tree().create_timer(speed).timeout  # Wait before adding next character
	is_typing = false  # Typing finished

	

func play_scene() -> void:
	if index < dialogue.size():  # Ensure index is within bounds
		if !is_typing:  # Only start typing if we are not already typing
			await show_typing_effect(dialogue[index], typing_speed)  # Type text
			index += 1  # Move to the next dialogue line
			print('play scene')
			
		else:
			print("Already typing, please wait.")  # Debugging statement
	else:	
		close_dialogue_panel()  # Close the dialogue panel if no more dialogue lines
		stopwatch.play()
		character_animation_sprite_2D.play()
		chest1.play()
		print("Debug: Game Resumed")
		get_tree().paused = false
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Mouse clicked!")  # Debugging: Check if it prints
		if !is_typing:
			print('play')
			play_scene()
			
			return
			

>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a
func _process(delta: float) -> void:
	camera.adjust_camera(50,50)
	pop_main_menu()
	interact_chess()
<<<<<<< HEAD
	comparing_answer(answer.user_input, answer.correct_answer)
=======
	
>>>>>>> f0537111bd1032f3c63e465d80a1ec923044218a

func interact_chess() -> void:
	handle_chest_interaction(label1, chest1, animation_control, animation_player, "chest1")
	handle_chest_interaction(label2, chest2, animation_control, animation_player, "chest2")
	handle_chest_interaction(label3, chest3, animation_control, animation_player, "chest3")
	handle_chest_interaction(label4, chest4, animation_control, animation_player, "chest4")

func handle_chest_interaction(label: Label, chest, animation_control: Control, animation_player: AnimationPlayer, chest_name: String) -> void:
	if label.visible and Input.is_action_just_pressed("interact"):
		animation_control.set_visible(true)
		chest._open_chest()
		interact_with_chest(chest_name)
		animation_player.play_slide()

func interact_with_chest(chest_name: String) -> void:
	if given_problem1.size() > 0 and available_indices.size() > 0:
		var random_index = available_indices[randi() % available_indices.size()]
		var selected_given = given_problem1[random_index]
		var selected_value = problem_value1[random_index]

		insremove(random_index)
		animation_label.text = "You got: %s" % [selected_given] + "\n Value: %s" % [selected_value]

		available_indices.erase(random_index)

func perform_calculations() -> void:
	for index in range(given_problem1.size()):
		if get_value1[index] == null:
			match given_problem1[index]:
				"Velocity":
					if get_value1[given_problem1.find("Angle")] != null and get_value1[given_problem1.find("Time of Flight")] != null:
						var angle = get_value1[given_problem1.find("Angle")]
						var time_of_flight = get_value1[given_problem1.find("Time of Flight")]
						var velocity = (gravity * time_of_flight) / (2 * sin(deg_to_rad(angle)))
						print("Debug: Velocity calculated: %s" % [velocity])
						answer.correct_answer = velocity
						

				"Angle":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Time of Flight")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var time_of_flight = get_value1[given_problem1.find("Time of Flight")]
						var angle = rad_to_deg(asin((gravity * time_of_flight) / (2 * velocity)))
						print("Debug: Angle calculated: %s" % [angle])
						answer.correct_answer = angle
						

				"Time of Flight":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var time_of_flight = (2 * velocity * sin(deg_to_rad(angle))) / gravity
						print("Debug: Time of Flight calculated: %s" % [time_of_flight])
						answer.correct_answer = time_of_flight
						

				"Max Height":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var max_height = (velocity * velocity * sin(deg_to_rad(angle)) * sin(deg_to_rad(angle))) / (2 * gravity)
						print("Debug: Max Height calculated: %s" % [max_height])
						answer.correct_answer = max_height
						

				"Range":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var range = (velocity * velocity * sin(2 * deg_to_rad(angle))) / gravity
						print("Debug: Range calculated: %s" % [range])
						answer.correct_answer = range

func _on_fire_timer_timeout() -> void:
	fire_timer.start()
	if !is_fire_paused:
		
		new_bullet = gun.bullet_scene.instantiate() 
		add_child(new_bullet)
		new_bullet.global_position = $HallwayMan/CharacterBody2D.get_global_transform().origin   
		print("Debug: HallwayMan global_position:", $HallwayMan/CharacterBody2D.global_position)
		print("Debug: Bullet pos: ", new_bullet.global_position)
		
		bullet_collision = new_bullet.get_node("Area2D")
		bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))

		print("Debug: Bullet CollisionShape2D found:", bullet_collision)
		change_of_hitting()

func comparing_answer(user_input: int, machine_calculated: int) -> void:
	if(machine_calculated == null):
		pass
	else:
		if(user_input == machine_calculated):
			print("Debug: Correct")
