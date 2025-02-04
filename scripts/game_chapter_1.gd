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

@onready var prompt_label1 = $ENUMAN/Camera2D/Panel/Label1
@onready var prompt_label2 = $ENUMAN/Camera2D/Panel/Label2
@onready var prompt_label3 = $ENUMAN/Camera2D/Panel/Label3
@onready var prompt_label4 = $ENUMAN/Camera2D/Panel/Label4
@onready var prompt_label5 = $ENUMAN/Camera2D/Panel/Label5

@onready var pressure_plate1 = $pressure_plate1/Area2D

@onready var stopwatch = $CanvasLayer/Hud 

@onready var camera = $ENUMAN

var is_paused = false
#var pause_decision = tru
var prompt_label_list = []

var given_problem1 = ["Velocity", "Angle", "Time of Flight", "Max Height", "Range"]
var problem_value1 = [null, null, null, null, null]
var get_value1 = [null, null, null, null, null]
var get_given_value1 = [null, null, null, null, null]
var available_indices = []

var gravity = 9.8

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
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	print('Debug: ito po ang gumagana game_chapter_1.gd/script')
	randomize_problem_values()
	available_indices = range(given_problem1.size())


	prompt_label_list = [prompt_label1, prompt_label2, prompt_label3, prompt_label4, prompt_label5]

	pressure_plate1.connect("body_entered", Callable(self, "_on_pressure_plate_entered"))
	pressure_plate1.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))

func _on_pressure_plate_entered(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN stepped on the pressure plate!")
		open_panel()
		perform_calculations()

func pop_main_menu() -> void:
	if Input.is_action_just_pressed("escape"):
		is_paused = !is_paused
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
	for index in range(given_problem1.size()):
		if get_value1[index] == null:
			prompt_label_list[index].text = "?"
			print("Missing value for: %s" % [given_problem1[index]])
		else:
			prompt_label_list[index].text = "%s: %s" % [given_problem1[index], get_value1[index]]

func close_panel() -> void:
	prompt_panel.set_visible(false)
	print("Debug: Panel is now closed")


func _process(delta: float) -> void:
	camera.adjust_camera(60,60)
	pop_main_menu()
	interact_chess()

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
						get_value1[index] = velocity
						print("Debug: Velocity calculated: %s" % [velocity])

				"Angle":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Time of Flight")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var time_of_flight = get_value1[given_problem1.find("Time of Flight")]
						var angle = rad_to_deg(asin((gravity * time_of_flight) / (2 * velocity)))
						get_value1[index] = angle
						print("Debug: Angle calculated: %s" % [angle])

				"Time of Flight":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var time_of_flight = (2 * velocity * sin(deg_to_rad(angle))) / gravity
						get_value1[index] = time_of_flight
						print("Debug: Time of Flight calculated: %s" % [time_of_flight])

				"Max Height":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var max_height = (velocity * velocity * sin(deg_to_rad(angle)) * sin(deg_to_rad(angle))) / (2 * gravity)
						get_value1[index] = max_height
						print("Debug: Max Height calculated: %s" % [max_height])

				"Range":
					if get_value1[given_problem1.find("Velocity")] != null and get_value1[given_problem1.find("Angle")] != null:
						var velocity = get_value1[given_problem1.find("Velocity")]
						var angle = get_value1[given_problem1.find("Angle")]
						var range = (velocity * velocity * sin(2 * deg_to_rad(angle))) / gravity
						get_value1[index] = range
						print("Debug: Range calculated: %s" % [range])
