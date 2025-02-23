extends Node2D
@onready var camera = $Character_Handler/ENUMAN/Camera2D
@onready var collision_shape = $Character_Handler/ENUMAN/CollisionShape2D

@onready var hallwayman1 = $HallwayMan1/CharacterBody2D
@onready var hallwayman_area_2D1 = $HallwayMan1/CharacterBody2D/Area2D

@onready var hallwayman2 = $HallwayMan2/CharacterBody2D
@onready var hallwayman_area_2D2 = $HallwayMan2/CharacterBody2D/Area2D

@onready var hallwayman3 = $HallwayMan3/CharacterBody2D
@onready var hallwayman_area_2D3 = $HallwayMan3/CharacterBody2D/Area2D

@onready var hallwayman4 = $HallwayMan4/CharacterBody2D
@onready var hallwayman_area_2D4 = $HallwayMan4/CharacterBody2D/Area2D

@onready var hallwayman5 = $HallwayMan5/CharacterBody2D
@onready var hallwayman_area_2D5 = $HallwayMan5/CharacterBody2D/Area2D

@onready var hallwayman6 = $HallwayMan6/CharacterBody2D
@onready var hallwayman_area_2D6 = $HallwayMan6/CharacterBody2D/Area2D

@onready var hallwayman7 = $HallwayMan7/CharacterBody2D
@onready var hallwayman_area_2D7 = $HallwayMan7/CharacterBody2D/Area2D

@onready var hallwayman8 = $HallwayMan8/CharacterBody2D
@onready var hallwayman_area_2D8 = $HallwayMan8/CharacterBody2D/Area2D

@onready var hallway_bullet1 = $HallwayMan1/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet2 = $HallwayMan2/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet3 = $HallwayMan3/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet4 = $HallwayMan4/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet5 = $HallwayMan5/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet6 = $HallwayMan6/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet7 = $HallwayMan7/CharacterBody2D/CollisionShape2D
@onready var hallway_bullet8 = $HallwayMan8/CharacterBody2D/CollisionShape2D


@onready var gun1 = $HallwayMan1/CharacterBody2D
@onready var gun2 = $HallwayMan2/CharacterBody2D
@onready var gun3 = $HallwayMan3/CharacterBody2D
@onready var gun4 = $HallwayMan4/CharacterBody2D
@onready var gun5 = $HallwayMan5/CharacterBody2D
@onready var gun6 = $HallwayMan6/CharacterBody2D
@onready var gun7 = $HallwayMan7/CharacterBody2D
@onready var gun8 = $HallwayMan8/CharacterBody2D
@onready var gun_enuman = $Character_Handler/ENUMAN

@onready var fire_timer = $FireTimer
@onready var fire_timer_enuman = $FireTimerEnuman

@onready var enuman = $Character_Handler/ENUMAN
@onready var dog = $Character_Handler/Doggi
@onready var bite_collision_shape = $Character_Handler/Doggi/Area2D2/Bite_Collision_Shape
@onready var doggi_area2D = $Character_Handler/Doggi/Area2D2
@onready var pcam = $Character_Handler/PhantomCamera2D


@onready var prompt_panel = $CanvasLayer/problem_panel/Panel
@onready var prompt_label1 = $CanvasLayer/problem_panel/Panel/Label1
@onready var prompt_label2 = $CanvasLayer/problem_panel/Panel/Label2
@onready var prompt_label3 = $CanvasLayer/problem_panel/Panel/Label3
@onready var prompt_label4 = $CanvasLayer/problem_panel/Panel/Label4
@onready var prompt_label5 = $CanvasLayer/problem_panel/Panel/Label5
@onready var prompt_label6 = $CanvasLayer/problem_panel/Panel/Label6

@onready var problem_identifier = $CanvasLayer/problem_panel/Panel/ProblemIdentifier

@onready var animation_player = $CanvasLayer/Node2D/AnimationPlayer
@onready var animation_label = $CanvasLayer/Node2D/Control/Label
@onready var red_animation_panel = $Character_Handler/ENUMAN/Camera2D/Animation/Control
@onready var animation_panel = $CanvasLayer/Node2D/Control

@onready var answer = $CanvasLayer/problem_panel

@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label
@onready var label3 = $chest3/Area2D/Label
@onready var label4 = $chest4/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D
@onready var chest3 = $chest3/Area2D
@onready var chest4 = $chest4/Area2D
@onready var pressure_plate1 = $pressure_plate1/Area2D
@onready var barrier1 = $barrier1

@onready var label5 = $chest5/Area2D/Label
@onready var label6 = $chest6/Area2D/Label
@onready var label7 = $chest7/Area2D/Label
@onready var label8 = $chest8/Area2D/Label

@onready var chest5 = $chest5/Area2D
@onready var chest6 = $chest6/Area2D
@onready var chest7 = $chest7/Area2D
@onready var chest8 = $chest8/Area2D
@onready var pressure_plate2 = $pressure_plate2/Area2D
@onready var barrier2 = $barrier2

@onready var line_edit = $Character_Handler/ENUMAN/Camera2D/Panel/LineEdit
@onready var animation_control = $Character_Handler/ENUMAN/Camera2D/Animation/Control

@onready var form_book = $CanvasLayer/formula_book
@onready var manual_pause = $CanvasLayer/pause_menu
@onready var act_stopwatch = $Stopwatch
@onready var dialogue_data = $CanvasLayer/dialogue

@onready var portal_door = $portal_door

var current_shooter: int = 1 
var current_problem: int = 0
var correct_answer = 0
var last_problem = 0

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

var prompt_label_list = []

var bullet_scene
var bullet_collision
var bullet_collision_enuman

var is_fire_paused = true

var new_bullet
var new_bullet_enuman

var current_elevator = null
var current_floor: int = 5

@onready var elevator1 = $elevator1
@onready var elevator1_body = $elevator1/Area2D
@onready var elevator1_label = $elevator1/Label1
@onready var elevator2 = $elevator2
@onready var elevator2_body = $elevator2/Area2D
@onready var elevator2_label = $elevator2/Label1
@onready var elevator3 = $elevator3
@onready var elevator3_body = $elevator3/Area2D
@onready var elevator3_label = $elevator3/Label1
@onready var elevator4 = $elevator4
@onready var elevator4_body = $elevator4/Area2D
@onready var elevator4_label = $elevator4/Label1
@onready var elevator5 = $elevator5
@onready var elevator5_body = $elevator5/Area2D
@onready var elevator5_label = $elevator5/Label1
@onready var game_over = $CanvasLayer/game_over
@onready var animation_sensor = $portal_door/Area2D2
@onready var portal_area = $portal_door/Area2D

func _ready() -> void:
	portal_door.scene = load("res://scenes/2-Player/game_chapter_4.tscn")
	pcam.set_auto_zoom_max(2)
	pcam.set_auto_zoom(true)
	pcam.set_auto_zoom_margin(Vector4(40, 30, 40, 40))
	doggi_area2D.connect("body_entered", Callable(self,"when_hallwayman_hit"))
	
	randomize_problem_values()
	
	available_indices1 = range(given_problem1.size())
	available_indices2 = range(given_problem2.size())
	
	prompt_label_list = [prompt_label1, prompt_label2, prompt_label3, prompt_label4, prompt_label5]
	camera.enabled = false 
	collision_shape.global_position = enuman.global_position
	
	enuman.speed = 300
	dog.speed =325
	dog.JUMP_VELOCITY = -275
	enuman.JUMP_VELOCITY = -275
	
	$Character_Handler/ENUMAN/Camera2D/Animation.global_position = enuman.global_position + Vector2(800,-200)
	$Character_Handler/ENUMAN/Camera2D/Animation.scale = Vector2(0.3,0.3)
	animation_panel.scale = Vector2(1.5,1.5) 
	animation_panel.global_position = enuman.global_position + Vector2(-315,-90)
	
	hallwayman1.speed = 100
	hallwayman2.speed = 100
	hallwayman3.speed = 100
	hallwayman4.speed = 100
	hallwayman5.speed = 100
	hallwayman6.speed = 100
	hallwayman7.speed = 100
	hallwayman8.speed = 100
	
	pressure_plate1.connect("body_entered", Callable(self, "_on_pressure_plate_entered").bind(1))
	pressure_plate1.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))
	
	pressure_plate2.connect("body_entered", Callable(self, "_on_pressure_plate_entered").bind(2))
	pressure_plate2.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))
	
	hallwayman_area_2D1.connect("body_entered", Callable(self, "_on_hallway_enemy_entered").bind(1))
	hallwayman_area_2D1.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(1))
	
	hallwayman_area_2D2.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(2))
	hallwayman_area_2D2.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(2))
	
	hallwayman_area_2D3.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(3))
	hallwayman_area_2D3.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(3))
	
	hallwayman_area_2D4.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(4))
	hallwayman_area_2D4.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(4))
	
	hallwayman_area_2D5.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(5))
	hallwayman_area_2D5.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(5))
	
	hallwayman_area_2D6.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(6))
	hallwayman_area_2D6.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(6))
	
	hallwayman_area_2D7.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(7))
	hallwayman_area_2D7.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(7))
	
	hallwayman_area_2D8.connect("body_entered", Callable(self,"_on_hallway_enemy_entered").bind(8))
	hallwayman_area_2D8.connect("body_exited", Callable(self,"_on_hallway_enemy_exited").bind(8))
	
	elevator1_body.body_entered.connect(_on_elevator_area_entered.bind(elevator1))
	elevator1_body.body_exited.connect(_on_elevator_area_exited.bind(elevator1))
	
	elevator2_body.body_entered.connect(_on_elevator_area_entered.bind(elevator2))
	elevator2_body.body_exited.connect(_on_elevator_area_exited.bind(elevator2))
	
	elevator3_body.body_entered.connect(_on_elevator_area_entered.bind(elevator3))
	elevator3_body.body_exited.connect(_on_elevator_area_exited.bind(elevator3))
	
	elevator4_body.body_entered.connect(_on_elevator_area_entered.bind(elevator4))
	elevator4_body.body_exited.connect(_on_elevator_area_exited.bind(elevator4))
	
	elevator5_body.body_entered.connect(_on_elevator_area_entered.bind(elevator5))
	elevator5_body.body_exited.connect(_on_elevator_area_exited.bind(elevator5))
	
	elevator1.label2_hide()
	elevator5.label1_hide()
	
	new_bullet_enuman = gun_enuman.bullet_scene.instantiate()
	
	
	if answer.has_signal("answer_submitted"):
		answer.connect("answer_submitted", Callable(self, "_on_answer_submitted"))
		print("Debug: Successfully connected answer_submitted signal")
	else:
		print("Debug: ERROR - answer_submitted signal not found in ENUMAN")
	
	
	
	interact_chess()
	dialogue_data.pause()
	
	if animation_sensor != null:
		animation_sensor.connect("body_exited", Callable(self, "on_area2d_animation_exit"))
	if portal_area != null:
		portal_area.connect("body_entered", Callable(self, "on_area2d_portal_entered"))

func on_area2d_animation_enter(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		print("Debug: entered area 2d")
		$portal_door/AnimatedSprite2D.play("open")

func on_area2d_animation_exit(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		$portal_door/AnimatedSprite2D.play("close")

func on_area2d_portal_entered(body):
	if (body.name == "ENUMAN") or (body.name == "Doggi"):
		get_tree().change_scene_to_file("res://scripts/2-Player/game_chapter_4.gd")
		
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

func when_hallwayman_hit(body) -> void:
	if body.get_parent() == $HallwayMan1:
		$HallwayMan1/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan2:
		$HallwayMan2/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan3:
		$HallwayMan3/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan4:
		$HallwayMan4/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan5:
		$HallwayMan5/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan6:
		$HallwayMan6/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan7:
		$HallwayMan7/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan8:
		$HallwayMan8/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
		
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
	
func _on_pressure_plate_entered(body, problem_number: int):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		current_problem = problem_number
		last_problem = problem_number 
		print("Debug: Activated Pressure Plate for Problem ", current_problem)
		open_panel()
		perform_calculations()

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

func _on_pressure_plate_exited(body):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		print("Debug: ENUMAN left the pressure plate!")
		close_panel()
		
func open_panel() -> void:
	print("Debug: Open_panel opened: ", current_problem)
	prompt_panel.set_visible(true)
	line_edit.grab_focus()
	match (current_problem):
		1:
			prompt_label6.text = ""
			problem_identifier = "Kinematics"
			for index in range(given_problem1.size()):
				if get_value1[index] == null:
					prompt_label_list[index].text = "%s: ?" % given_problem1[index]
					print("Missing value for: %s" % [given_problem1[index]])
				else:
					prompt_label_list[index].text = "%s: %s" % [given_problem1[index], get_value1[index]]
		2:
			prompt_label6 = "Angle: %s" % [angle1]
			problem_identifier = "Work & Kinematics"
			for index in range(given_problem2.size()):
				if get_value2[index] == null:
					prompt_label_list[index].text = "%s: ?" % [given_problem2[index]]
					print("Missing value for: %s" % [given_problem2[index]])
				else:
					print("Debug: %s: %s" % [given_problem2[index], get_value2[index]])
					prompt_label_list[index].text = "%s: %s" % [given_problem2[index], get_value2[index]]

func close_panel() -> void:
	prompt_panel.set_visible(false)
	print("Debug: Panel is now closed")

func _on_elevator_area_entered(body, elevator):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		current_elevator = elevator

func _on_elevator_area_exited(body, elevator):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		current_elevator = null

func _input(event):
	if event.is_action_pressed("interact_go_up") and get_node("elevator" + str(current_floor) + "/Label1").visible:
		if current_floor < 6:
			enuman.hide()
			dog.hide()
			dog.speed = 0
			enuman.speed = 0
			$ElevatorTimer.start()
			get_node("elevator" + str(current_floor) + "/AnimatedSprite2D").play("entering")
			current_floor += 1
			enuman.global_position = get_node("elevator" + str(current_floor)).global_position
			dog.global_position = get_node("elevator" + str(current_floor)).global_position
			print("Debug: Moved Up to Floor", current_floor)

	elif event.is_action_pressed("interact_go_down") and get_node("elevator" + str(current_floor) + "/Label2").visible:
		if current_floor > 1:
			enuman.hide()
			enuman.speed = 0
			dog.hide()
			dog.speed = 0
			$ElevatorTimer.start()
			get_node("elevator" + str(current_floor) + "/AnimatedSprite2D").play("entering")
			current_floor -= 1
			enuman.global_position = get_node("elevator" + str(current_floor)).global_position
			dog.global_position = get_node("elevator" + str(current_floor)).global_position
			print("Debug: Moved Down to Floor", current_floor)
	
	if event.is_action_pressed("attack_dog"):
		dog.change_animation_to_attack()
		
	
	if event.is_action_pressed("skill_dog"):
		dog.change_animation_to_shield()

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
	elif body.get_parent() == $HallwayMan3:
		$HallwayMan3/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan4:
		$HallwayMan4/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan5:
		$HallwayMan5/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan6:
		$HallwayMan6/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan7:
		$HallwayMan7/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() == $HallwayMan8:
		$HallwayMan8/CharacterBody2D.change_animation_to_dead()
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true
	elif body.get_parent() != null && body.get_parent() != $Character_Handler: 
		new_bullet_enuman.change_animation_hit()
		new_bullet_enuman.is_hit = true

func firing() -> void:
	if(Input.is_action_just_pressed("fire")):
		fire_timer_enuman.start()
		enuman.change_animation_to_shoot()
		await fire_timer_enuman.timeout
		enuman.speed = 300

func _process(delta: float) -> void:
	firing()
	interact_chess()
	red_animation_panel.visible = false

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
		animation_player.play_slide_part_2()

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
func _on_bullet_entered(body):
	if body.name == "ENUMAN" or (body.name == "Doggi"): 
		fire_timer.stop()
		new_bullet.change_animation_hit()
		new_bullet.is_hit = true
		print("napatay siya")
		game_over.visible = true
		game_over.showup()
	if body.name == "StaticBody2D":
		new_bullet.change_animation_hit()
		new_bullet.is_hit = true
		print("Shielded")

func _on_hallway_enemy_entered(body, enemy_id: int):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		current_shooter = enemy_id
		print("Debug:Comes in here")
		match current_shooter:
			1:
				hallwayman1.change_animation_to_shoot()
			2:
				hallwayman2.change_animation_to_shoot()
			3:
				hallwayman3.change_animation_to_shoot()
			4: 
				hallwayman4.change_animation_to_shoot()
			5:
				hallwayman5.change_animation_to_shoot()
			6:
				hallwayman6.change_animation_to_shoot()
			7:
				hallwayman7.change_animation_to_shoot()
			8:
				hallwayman8.change_animation_to_shoot()

		is_fire_paused = false
		print("Debug: is_fire_paused status: ", is_fire_paused)
		get_bullet_collision()

func _on_hallway_enemy_exited(body, enemy_id: int):
	if body.name == "ENUMAN" or (body.name == "Doggi"):
		current_shooter = enemy_id
		match enemy_id:
			1:
				hallwayman1.change_animation_to_walk()
				hallwayman1.speed = 100
			2:
				hallwayman2.change_animation_to_walk()
				hallwayman2.speed = 100
			3:
				hallwayman3.change_animation_to_walk()
				hallwayman3.speed = 100
			4:
				hallwayman4.change_animation_to_walk()
				hallwayman4.speed = 100
			5:
				hallwayman5.change_animation_to_walk()
				hallwayman5.speed = 100
			6:
				hallwayman6.change_animation_to_walk()
				hallwayman6.speed = 100
			7:
				hallwayman7.change_animation_to_walk()
				hallwayman7.speed = 100
			8:
				hallwayman8.change_animation_to_walk()
				hallwayman8.speed = 100
		is_fire_paused = true

func get_bullet_collision():
	fire_timer.start()

func change_of_hitting(enemy_id: int) -> void:
	match enemy_id:
		1:
			if(new_bullet == null):
				new_bullet = gun1.bullet_scene.instantiate()
				
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman1.is_moving_left
		2:
			if(new_bullet == null):
				new_bullet = gun2.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman2.is_moving_left
			
		3:
			if(new_bullet == null):
				new_bullet = gun3.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman3.is_moving_left
			
		4:
			if(new_bullet == null):
				new_bullet = gun4.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman4.is_moving_left
		5:
			if(new_bullet == null):
				new_bullet = gun5.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman5.is_moving_left
		6:
			if(new_bullet == null):
				new_bullet = gun6.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman6.is_moving_left
		7:
			if(new_bullet == null):
				new_bullet = gun7.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman7.is_moving_left
		8:
			if(new_bullet == null):
				new_bullet = gun8.bullet_scene.instantiate()
			
			new_bullet.change_scale_to()
			new_bullet.hitting_right = !hallwayman8.is_moving_left

func game_over_panel():
	print("Debug: Game Over")

func _on_fire_timer_timeout() -> void:
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
				print("Debug: HallwayMan global_position:", $HallwayMan2/CharacterBody2D.global_position)
			
			3:
				new_bullet = gun3.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan3/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan3/CharacterBody2D.global_position)

			4:
				new_bullet = gun4.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan4/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan4/CharacterBody2D.global_position)
			
			5:
				new_bullet = gun5.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan5/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan5/CharacterBody2D.global_position)
			
			6:
				new_bullet = gun6.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan6/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan6/CharacterBody2D.global_position)
			
			7:
				new_bullet = gun7.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan7/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan7/CharacterBody2D.global_position)
			
			8:
				new_bullet = gun8.bullet_scene.instantiate()
				add_child(new_bullet)
				new_bullet.global_position = $HallwayMan8/CharacterBody2D.get_global_transform().origin   
				bullet_collision = new_bullet.get_node("Area2D")
				bullet_collision.connect("body_entered", Callable(self, "_on_bullet_entered"))
				print("Debug: Bullet CollisionShape2D found:", bullet_collision)
				print("Debug: HallwayMan global_position:", $HallwayMan8/CharacterBody2D.global_position)
	change_of_hitting(current_shooter)

func _on_fire_timer_enuman_timeout() -> void:
		new_bullet_enuman.change_to_visible()
		new_bullet_enuman.change_scale_to()
		new_bullet_enuman.hitting_right = !enuman.is_moving_left
		add_child(new_bullet_enuman)
		new_bullet_enuman.global_position = enuman.get_global_transform().origin + Vector2(6, -4.9)
		bullet_collision_enuman = new_bullet_enuman.get_node("Area2D")
		bullet_collision_enuman.connect("body_entered", Callable(self, "_on_bullet_entered_hallwayman"))

func _on_elevator_timer_timeout() -> void:
	enuman.show()
	enuman.speed = 300
	dog.show()
	dog.speed = 325
