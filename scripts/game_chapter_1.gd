extends Node2D
# game chapter 1
@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label
@onready var label3 = $chest3/Area2D/Label
@onready var label4 = $chest4/Area2D/Label
@onready var label5 = $chest5/Area2D/Label
@onready var label6 = $chest6/Area2D/Label
@onready var label7 = $chest7/Area2D/Label
@onready var label8 = $chest8/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D
@onready var chest3 = $chest3/Area2D
@onready var chest4 = $chest4/Area2D
@onready var pressure_plate1 = $pressure_plate1/Area2D
@onready var barrier1 = $Barrier1

@onready var chest5 = $chest5/Area2D
@onready var chest6 = $chest6/Area2D
@onready var chest7 = $chest7/Area2D
@onready var chest8 = $chest8/Area2D
@onready var pressure_plate2 = $pressure_plate2/Area2D
@onready var barrier2 = $Barrier2

@onready var chest1animation = $chest1

@onready var character_animation_sprite_2D = $Character_Handler/ENUMAN/AnimatedSprite2D

@onready var animation_player = $Character_Handler/ENUMAN/Camera2D/Animation/AnimationPlayer
@onready var animation_label = $Character_Handler/ENUMAN/Camera2D/Animation/Control/Label

@onready var animation_control = $Character_Handler/ENUMAN/Camera2D/Animation/Control

@onready var prompt_panel = $Character_Handler/ENUMAN/Camera2D/Panel

@onready var prompt_label1 = $Character_Handler/ENUMAN/Camera2D/Panel/Label1
@onready var prompt_label2 = $Character_Handler/ENUMAN/Camera2D/Panel/Label2
@onready var prompt_label3 = $Character_Handler/ENUMAN/Camera2D/Panel/Label3
@onready var prompt_label4 = $Character_Handler/ENUMAN/Camera2D/Panel/Label4
@onready var prompt_label5 = $Character_Handler/ENUMAN/Camera2D/Panel/Label5
@onready var prompt_label6 = $Character_Handler/ENUMAN/Camera2D/Panel/Label6

@onready var problem_identifier = $Character_Handler/ENUMAN/Camera2D/Panel/ProblemIdentifier

@onready var stopwatch = $CanvasLayer/Hud 
@onready var act_stopwatch = $Stopwatch

@onready var camera = $Character_Handler/ENUMAN

@onready var answer = $Character_Handler/ENUMAN

var current_shooter: int = 1 
@onready var hallwayman1 = $HallwayMan1/CharacterBody2D
@onready var hallwayman_area_2D1 = $HallwayMan1/CharacterBody2D/Area2D

@onready var hallwayman2 = $HallwayMan2/CharacterBody2D
@onready var hallwayman_area_2D2 = $HallwayMan2/CharacterBody2D/Area2D

@onready var enuman = $Character_Handler/ENUMAN

@onready var hallway_bullet1 = $HallwayMan1/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet2 = $HallwayMan2/CharacterBody2D/CollisionShape2D

@onready var gun1 = $HallwayMan1/CharacterBody2D
@onready var gun2 = $HallwayMan2/CharacterBody2D
@onready var fire_timer = $FireTimer

@onready var gun_enuman = $Character_Handler/ENUMAN
@onready var fire_timer_enuman = $FireTimerEnuman


@onready var line_edit = $Character_Handler/ENUMAN/Camera2D/Panel/LineEdit

@onready var manual_pause = $CanvasLayer/pause_menu


@onready var form_book = $CanvasLayer/formula_book


@onready var dialogue_data = $CanvasLayer/dialogue
@onready var game_over = $CanvasLayer/game_over

@onready var portal_door = $portal_door

var current_problem: int = 0

var correct_answer = 0
var last_problem = 0

var bullet_scene

var bullet_collision
var bullet_collision_enuman

var is_fire_paused = true
var is_paused = false
var prompt_label_list = []

var given_problem1 = ["Velocity", "Angle", "Time of Flight", "Max Height", "Range"] #string
var problem_value1 = [null, null, null, null, null] #Double which is to get the value of the given
var get_value1 = [null, null, null, null, null]
var get_given_value1 = [null, null, null, null, null]
var available_indices1 = []

var angle1 = (randi() % 180)
var given_problem2 = ["Work", "Force", "Distance", "Time", "Power"]
var problem_value2 = [null, null, null, null, null]
var get_value2 = [null, null, null, null, null]
var get_given_value2 = [null, null, null, null, null] #String
var available_indices2 = []

var gravity = 9.8


var formula1: float = 0.0
var index = 0  # Tracks the current line
var typing_speed = 0.0005  # Adjust typing speed (seconds per character)
var is_typing = false  # Prevent skipping during typing
var new_bullet
var new_bullet_enuman

func randomize_problem_values() -> void:
	var velocity = (randi() % 100) + 30  
	var angle = (randi() % 60) + 30      

	var time_of_flight = (2 * velocity * sin(deg_to_rad(angle))) / gravity
	var max_height = (velocity * velocity * sin(deg_to_rad(angle)) * sin(deg_to_rad(angle))) / (2 * gravity)
	var range = (velocity * velocity * sin(2 * deg_to_rad(angle))) / gravity
	
	var force = (randi() % 100) + 20  
	var distance = (randi() % 50) + 10  
	var time = (randi() % 30) + 5     
	
	var work = force * distance * cos(deg_to_rad(angle1))       
	var power = work / time     
		  
	time_of_flight = snappedf(time_of_flight, 0.01)
	max_height = snappedf(max_height, 0.01)
	range = snappedf(range, 0.01)
	work = snappedf(work, 0.01)
	power = snappedf(power, 0.01)

	
	problem_value1 = [velocity, angle, time_of_flight, max_height, range]
	problem_value2 = [work, force, distance, time, power]
	print("Debug: Velocity = ", velocity, "Detta | Angle = ", angle, "T | Time of Flight = ", time_of_flight, "M | Max Height = ", max_height, "R | Range = ", range)
	print("Debug: Work = ", work, " J | Force = ", force, " N | Distance = ", distance, " m | Angle = ", angle1, "° | Time = ", time, " s | Power = ", power, " W")

func _ready() -> void:
	Timescore.record_time_score
	
	portal_door.scene = load("res://scenes/game_chapter_2.tscn")
	randomize_problem_values()
	available_indices1 = range(given_problem1.size())
	available_indices2 = range(given_problem2.size())
	dialogue_data.set_dialogue([
	"The possibilities are endless. The world is your canvas, waiting for your brushstrokes of imagination to breathe life into it.",
	"From the depths of the ocean to the vastness of space, there are stories to be told and adventures to be had.",
	"Take a leap of faith into the unknown, for it is there that the magic happens.",
	"Embrace the uncertainty, the challenges, and the beauty that lies within every step of the journey. So, go forth, and create your own masterpiece."])
	prompt_label_list = [prompt_label1, prompt_label2, prompt_label3, prompt_label4, prompt_label5]
	pressure_plate1.connect("body_entered", Callable(self, "_on_pressure_plate_entered").bind(1))
	pressure_plate1.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))
	
	pressure_plate2.connect("body_entered", Callable(self,"_on_pressure_plate_entered").bind(2))
	pressure_plate2.connect("body_exited", Callable(self,"_on_pressure_plate_exited"))
	
	hallwayman_area_2D1.connect("body_entered", Callable(self, "_on_hallway_enemy_entered").bind(1))
	hallwayman_area_2D1.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(1))
	
	hallwayman_area_2D2.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(2))
	hallwayman_area_2D2.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(2))
	
	
	
	line_edit.text_submitted.connect($Character_Handler/ENUMAN._on_line_edit_text_submitted)
	
	new_bullet_enuman = gun_enuman.bullet_scene.instantiate()
	
	if answer.has_signal("answer_submitted"):
		answer.connect("answer_submitted", Callable(self, "_on_answer_submitted"))
		print("Debug: Successfully connected answer_submitted signal")
	else:
		print("Debug: ERROR - answer_submitted signal not found in ENUMAN")
	
	camera.adjust_camera(50,50)
	interact_chess()
	dialogue_data.pause()



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

func _on_bullet_entered(body):
	if body.name == "ENUMAN":
		fire_timer.stop()
		new_bullet.change_animation_hit()
		new_bullet.is_hit = true
		game_over.visible = true
		game_over.showup()
		print("napatay siya")
		
func _on_bullet_entered_hallwayman(body):
	print("Debug: it satisfies", body.name)
	if body.get_parent() == $HallwayMan1:
		$HallwayMan1/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan2:
		$HallwayMan2/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
		

func game_over_panel():
	print("game over")

func _on_bullet_exited(body):
	if body.name == "ENUMAN":
		print("tumagos gago!")

func _on_hallway_enemy_entered(body, enemy_id: int):
	if body.name == "ENUMAN":
		current_shooter = enemy_id
		print("Debug:Comes in here")
		match current_shooter:
			1:
				hallwayman1.change_animation_to_shoot()
				hallwayman1.speed = 0

			2:
				print("Debug: on hallway enemy entered 2")
				hallwayman2.change_animation_to_shoot()
				hallwayman2.speed = 0


		is_fire_paused = false
		print("Debug: is_fire_paused status: ", is_fire_paused)
		get_bullet_collision()

func _on_hallway_enemy_exited(body, enemy_id: int):
	if body.name == "ENUMAN":
		current_shooter = enemy_id
		match enemy_id:
			1:
				hallwayman1.change_animation_to_walk()
				hallwayman1.speed = 7
			2:
				hallwayman2.change_animation_to_walk()
				hallwayman2.speed = 7
		is_fire_paused = true

func get_bullet_collision():
	fire_timer.start()

func _on_pressure_plate_entered(body, problem_number: int):
	if body.name == "ENUMAN":
		current_problem = problem_number
		last_problem = problem_number 
		print("Debug: Activated Pressure Plate for Problem ", current_problem)
		open_panel()
		perform_calculations()

func change_of_hitting(enemy_id: int) -> void:
	match enemy_id:
		1:
			if(new_bullet == null):
				new_bullet = gun1.bullet_scene.instantiate()
			new_bullet.hitting_right = !hallwayman1.is_moving_left
		2:
			if(new_bullet == null):
				new_bullet = gun2.bullet_scene.instantiate()
			new_bullet.hitting_right = !hallwayman2.is_moving_left

func _on_pressure_plate_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the pressure plate!")
		close_panel()

func insremove(random_index: int, current_problem: int) -> void:
	match(current_problem):
		1:
			if get_value1[random_index] == null:
				get_value1.remove_at(random_index)
				get_value1.insert(random_index, problem_value1[random_index])
				get_given_value1.remove_at(random_index)
				get_given_value1.insert(random_index, given_problem1[random_index])
	
		2:
			if get_value2[random_index] == null:
				get_value2.remove_at(random_index)
				get_value2.insert(random_index, problem_value2[random_index])
				get_given_value2.remove_at(random_index)
				get_given_value2.insert(random_index, given_problem2[random_index])

func open_panel() -> void:
	print("Debug: Open_panel opened: ", current_problem)
	prompt_panel.set_visible(true)
	line_edit.grab_focus()
	match (current_problem):
		1:
			prompt_label6.text = ""
			problem_identifier.text = "Kinematics"
			for index in range(given_problem1.size()):
				if get_value1[index] == null:
					prompt_label_list[index].text = "%s: ?" % given_problem1[index]
					print("Missing value for: %s" % [given_problem1[index]])
				else:
					prompt_label_list[index].text = "%s: %s" % [given_problem1[index], get_value1[index]]
		2:
			prompt_label6.text = "Angle: " % [angle1]
			problem_identifier.text = "Work & Power"
			for index in range(given_problem2.size()):
				if get_value2[index] == null:
					prompt_label_list[index].text = "%s: ?" % given_problem2[index]
					print("Missing value for: %s" % [given_problem2[index]])
				else:
					print("Debug: %s: %s" % [given_problem2[index], get_value2[index]])
					prompt_label_list[index].text = "%s: %s" % [given_problem2[index], get_value2[index]]

func close_panel() -> void:
	prompt_panel.set_visible(false)
	print("Debug: Panel is now closed")



func _process(delta: float) -> void:
	camera.adjust_camera(50,50)
	interact_chess()
	firing()
	if (enuman.global_position.y > 300):
		fell_off_map()

func fell_off_map():
	game_over.visible = true
	game_over.showup()

func firing() -> void:
	if(Input.is_action_just_pressed("fire")):
		fire_timer_enuman.start()
		enuman.change_animation_to_shoot()
		await fire_timer_enuman.timeout
		enuman.speed = 50

func interact_chess() -> void:
	handle_chest_interaction(label1, chest1, animation_control, animation_player, "chest1", 1)
	handle_chest_interaction(label2, chest2, animation_control, animation_player, "chest2", 1)
	handle_chest_interaction(label3, chest3, animation_control, animation_player, "chest3", 1)
	handle_chest_interaction(label4, chest4, animation_control, animation_player, "chest4", 1)
	
	handle_chest_interaction(label5, chest5, animation_control, animation_player, "chest5", 2)
	handle_chest_interaction(label6, chest6, animation_control, animation_player, "chest6", 2)
	handle_chest_interaction(label7, chest7, animation_control, animation_player, "chest7", 2)
	handle_chest_interaction(label8, chest8, animation_control, animation_player, "chest8", 2)

func handle_chest_interaction(label: Label, chest, animation_control: Control, animation_player: AnimationPlayer, chest_name: String, current_problem_identifier: int) -> void:
	current_problem = current_problem_identifier
	if label.visible and Input.is_action_just_pressed("interact"):
		animation_control.set_visible(true)
		chest._open_chest()
		interact_with_chest(chest_name, current_problem)
		animation_player.play_slide()
		chest.hide_label()

func interact_with_chest(chest_name: String, current_problem: int) -> void:
	match(current_problem):
		1:
			if given_problem1.size() > 0 and available_indices1.size() > 0:
				var random_index = available_indices1[randi() % available_indices1.size()]
				var selected_given = given_problem1[random_index]
				var selected_value = problem_value1[random_index]
				available_indices1.erase(random_index)
				insremove(random_index, current_problem)	
				animation_label.text = "You got: %s" % [selected_given] + "\n Value: %s" % [selected_value]
		2:
			if given_problem2.size() > 0 and available_indices2.size() > 0:
				var random_index = available_indices2[randi() % available_indices2.size()]
				var selected_given = given_problem2[random_index]
				var selected_value = problem_value2[random_index]
				available_indices2.erase(random_index)
				insremove(random_index, current_problem)
				animation_label.text = "You got: %s" % [selected_given] + "\n Value: %s" % [selected_value]

func perform_calculations() -> void:
	var given_problem = given_problem1 if current_problem == 1 else given_problem2
	var problem_value = problem_value1 if current_problem == 1 else problem_value2
	match(current_problem):
		1:
			for index in range(given_problem1.size()):
				if get_value1[index] == null:
					match given_problem1[index]:
						"Velocity":
							answer.correct_answer = formula(get_value1, given_problem1, "Angle", "Range", "Vel	ocity")
							print("Debug: Velocity Calculated", answer.correct_answer)

						"Angle":
							answer.correct_answer = formula(get_value1, given_problem1, "Velocity", "Range", "Angle")
							print("Debug: P1: Angle Calculated: ", answer.correct_answer)

						"Time of Flight":
							answer.correct_answer = formula(get_value1, given_problem1, "Velocity", "Angle", "Time of Flight")
							print("Debug: P1: Time of Flight Calculated: ", answer.correct_answer)

						"Max Height":
							answer.correct_answer = formula(get_value1, given_problem1, "Velocity", "Angle", "Max Height")
							print("Debug: P1: Max Height Calculated: ", answer.correct_answer)

						"Range":
							answer.correct_answer = formula(get_value1, given_problem1, "Velocity", "Angle", "Range")
							print("Debug: P1: Range Calculated: ", answer.correct_answer)
		2:
			for index in range(given_problem2.size()):
				if get_value2[index] == null:
					match given_problem2[index]: #work, force, disrance, time power
						"Work":
							answer.correct_answer = formula(get_value2, given_problem2, "Force", "Distance", "Work")
							print("Debug: P2: Work Calculated: ", answer.correct_answer)
						"Force":
							answer.correct_answer = formula(get_value2, given_problem2, "Work", "Distance", "Force")
							print("Debug: P2: Force Calculated: ", answer.correct_answer)
						"Distance":
							answer.correct_answer = formula(get_value2, given_problem2, "Work", "Force", "Distance")
							print("Debug: P2: Distance Calculated: ", answer.correct_answer)
						"Time":
							answer.correct_answer = formula(get_value2, given_problem2, "Work", "Power", "Time")
							print("Debug: P2: Time Calculated: ", answer.correct_answer)
						"Power":
							answer.correct_answer = formula(get_value2, given_problem2, "Work", "Time", "Power")
							print("Debug: P2: Power Calculated: ", answer.correct_answer)

func formula(get_value: Array, given_problem: Array, given_problem_given1: String, given_problem_given2: String, find: String) -> float:
	if get_value[given_problem.find(given_problem_given1)] != null and get_value[given_problem.find(given_problem_given2)] != null:
		match (current_problem):
			1:
				var value1 = get_value[given_problem.find(given_problem_given1)]
				var value2 = get_value[given_problem.find(given_problem_given2)]
				match find:
					"Velocity":
						print("Debug: Current Problem: ", current_problem)
						return (gravity * value2) / (2 * sin(deg_to_rad(value1)))
					"Angle":
						print("Debug: Current Problem: ", current_problem)
						return 0.5 * rad_to_deg(asin((gravity * value2) / (value1 * value1)))
					"Time of Flight":
						print("Debug: Current Problem: ", current_problem)
						return (2 * value1 * sin(deg_to_rad(value2))) / gravity 
					"Max Height":
						print("Debug: Current Problem: ", current_problem)
						return (value1 * value1 * sin(deg_to_rad(value2)) * sin(deg_to_rad(value2))) / (2 * gravity)  
					"Range":
						print("Debug: Current Problem: ", current_problem)
						return (value1 * value1 * sin(2 * deg_to_rad(value2))) / gravity 
					_:
						print("Debug: Invalid 'find' parameter mosh")
						return 0.0
			2:
				var value1 = get_value[given_problem.find(given_problem_given1)]
				var value2 = get_value[given_problem.find(given_problem_given2)]
				match find:
					"Work":
						return value1 * value2 * cos(deg_to_rad(angle1))
					"Force":
						return value1 / (value2 * cos(deg_to_rad(angle1)))
					"Distance":
						return value1 / (value2 * cos(deg_to_rad(angle1)))
					"Time":
						return value1 / value2
					"Power":
						return value1 / value2
					_:
						print("Debug: Invalid 'find' parameter mosh")
						return 0.0
			_:
				print("Debug: Missing 'current problem mosh'")
				return 0.0
	else:
		print("Debug: Missing required values for calculation.")
		return 0.0

func _on_fire_timer_timeout() -> void:
	print("Debug: another timer starts")
	fire_timer.start()
	if !is_fire_paused: 
		print("Debug: Satisfied in the if statement")
		print("Debug: current_shooter num: ", current_shooter)
		match current_shooter:
			1:
				print("Debug: Inside num 1, instantiating...")
				new_bullet = gun1.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan1/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan1/CharacterBody2D.global_position)
			2:
				new_bullet = gun2.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan2/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)

	change_of_hitting(current_shooter)

func _on_answer_submitted(user_input: int) -> void:
	current_problem = last_problem
	comparing_answer(user_input, answer.correct_answer, current_problem)

func comparing_answer(user_input: float, machine_calculated: float, current_problem:int) -> void:
	var tolerance = 0.01
	print("Debug: Problem Current in comparing answer", current_problem)
	match (current_problem):
		1:
			print("Debug: Pumapasok siya dito sa pressure plate 1")
			if machine_calculated != null:
				if abs(user_input - machine_calculated) < tolerance:
					print("Debug: Correct Answer for Pressure Plate 1")
					barrier1.disable = true
					barrier1.disable_barrier()
					pressure_plate1.disable_collision()
				else:
					print("Debug: Incorrect Answer!")
		2:
			if machine_calculated != null:
				if abs(user_input - machine_calculated) < tolerance:
					print("Debug: Correct Answer for Pressure Plate 2")
					barrier2.disable = true
					barrier2.disable_barrier()
					pressure_plate2.disable_collision()
				else:
					print("Debug: Incorrect Answer!")


func _on_fire_timer_enuman_timeout() -> void:
		new_bullet_enuman.change_to_visible()
		new_bullet_enuman.hitting_right = !enuman.is_moving_left
		add_child(new_bullet_enuman)
		new_bullet_enuman.global_position = enuman.get_global_transform().origin + Vector2(6, -1.9)
		bullet_collision_enuman = new_bullet_enuman.get_node("Area2D")
		bullet_collision_enuman.connect("body_entered", Callable(self, "_on_bullet_entered_hallwayman"))
		
