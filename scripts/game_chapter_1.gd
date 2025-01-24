extends Node2D

@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label
@onready var label3 = $chest3/Area2D/Label
@onready var label4 = $chest4/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D
@onready var chest3 = $chest3/Area2D
@onready var chest4 = $chest4/Area2D

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
var prompt_label_list = []

var given_problem1 = ["Velocity", "Angle", "Time of Max Height", "Max Height", "Range"]
var problem_value1 = [40.0, 50.0, 6.25, 47.9, 160.78]
var get_value1 = [null, null, null, null, null]
var get_given_value1 = [null, null, null, null, null]
var available_indices = []

var random_index = randi() % given_problem1.size()
var problem_selector = randi() % given_problem1.size() # Aim to give emphasize on what he will need to get problem

func _ready() -> void:
	
	available_indices = range(given_problem1.size())
	
	prompt_label_list = [prompt_label1, prompt_label2, prompt_label3, prompt_label4, prompt_label5]
	for label in prompt_label_list:
		if label == null:
			print("Error: A label in prompt_label_list is null!")
	
	pressure_plate1.connect("body_entered", Callable(self, "_on_pressure_plate_entered"))
	pressure_plate1.connect("body_exited", Callable(self, "_on_pressure_plate_exited"))
	
	self.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	self.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func _on_pressure_plate_entered(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN stepped on the pressure plate!")
		open_panel()
	
func _on_pressure_plate_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the pressure plate!")
		close_panel()

# Opens the panel and sets the text
func open_panel() -> void:
	print("Debug: Open_panel opened")
	prompt_panel.set_visible(true)
	for index in range(given_problem1.size()):
		if (prompt_label_list[index].text == "Prompt"|| prompt_label_list[index].text == "?") && get_value1[index] == null:
			prompt_label_list[index].text = "?"
			print("Skipped %s" %[index])
		else:
			prompt_label_list[index].text = "%s" % [get_given_value1[index]] + ": %s" % [get_value1[index]]
	

func close_panel() -> void:
	prompt_panel.set_visible(false)
	print("Debug: Panel is now closed sa bahay ni kuya")

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	interact_chess()
	pass

func interact_chess() -> void:
	handle_chest_interaction(label1, chest1, animation_control, animation_player, "chest1")
	handle_chest_interaction(label2, chest2, animation_control, animation_player, "chest2")

func handle_chest_interaction(label: Label, chest, animation_control: Control, animation_player: AnimationPlayer, chest_name: String) -> void:
	if label.visible and Input.is_action_just_pressed("interact"):
		animation_control.set_visible(true)
		chest._open_chest()
		interact_with_chest(chest_name)
		animation_player.play_slide()

func insremove(random_index: int) -> void:
	if get_value1[random_index] == null:
		get_value1.remove_at(random_index)
		get_value1.insert(random_index, problem_value1[random_index])
		get_given_value1.remove_at(random_index)
		get_given_value1.insert(random_index, given_problem1[random_index])
		
func interact_with_chest(chest_name: String) -> void:
	if given_problem1.size() > 0 and available_indices.size() > 0:
		var random_index = available_indices[randi() % available_indices.size()]
		
		var selected_given = given_problem1[random_index]
		var selected_value = problem_value1[random_index]
		insremove(random_index)
		available_indices.erase(random_index)

		print("Debug: the get_value1 list inserted another value of %s" % [selected_value] + "\nDebug: its given is/are %s" % [selected_given])
		print("Debug: the value it inserted in %s" % [selected_value] + "\nDebug: at random index: %s" % [random_index])

		animation_label.text = "You got: %s" % [selected_given] + "\n Value: %s" % [selected_value]

		print("Debug: The list get_value1 var are: %s" % [get_value1])
	else:
		print("Debug: There are no more chests formulas left")

func refresh_panel() -> void:
	
	pass
