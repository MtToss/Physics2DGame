extends Node2D

@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D

@onready var animation_player = $ENUMAN/Camera2D/Animation/AnimationPlayer
@onready var animation_label = $ENUMAN/Camera2D/Animation/Control/Label

@onready var animation_control = $ENUMAN/Camera2D/Animation/Control

@onready var prompt_panel = $ENUMAN/Camera2D/Panel

@onready var prompt_label1 = $ENUMAN/Camera2D/Panel/Label1
@onready var prompt_label2 = $ENUMAN/Camera2D/Panel/Label2
@onready var prompt_label3 = $ENUMAN/Camera2D/Panel/Label3
@onready var prompt_label4 = $ENUMAN/Camera2D/Panel/Label4
@onready var prompt_label5 = $ENUMAN/Camera2D/Panel/Label5

@onready var pressure_plate1 = $pressure_plate1

var problem1 = ["Velocity", "Angle", "Time of Max Height", "Max Height", "Range"]
var problem_value1 = [40.0, 50.0, 6.25, 47.9, 160.78]
var get_value1 = [null, null, null, null, null]


	
func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	self.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func _on_area2d_body_entered(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN entered the plate mosshing!")
func _on_area2d_body_exited(body):
	if body.name == "ENUMAN":
		print("Debug: ENUMAN left the plate mosshing!")

	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	interact_chess()
	pass

func interact_chess() -> void:
	if label1.visible and Input.is_action_just_pressed("interact"):
		prompt_panel.set_visible(true)
		
		animation_control.set_visible(true)
		chest1._open_chest()
		interact_with_chest("chest1")
		animation_player.play_slide()
	
	if label2.visible and Input.is_action_just_pressed("interact"):
		prompt_panel.set_visible(true)
		
		
		animation_control.set_visible(true)
		chest2._open_chest()
		interact_with_chest("chest2")
		animation_player.play_slide()

func interact_with_chest(chest_name: String) -> void:
	if problem1.size() > 0:

		var random_index = randi() % problem1.size()
		var problem_selector = randi() % problem1.size() # Aim to give emphasize on what he will need to get problem
		
		var selected_given = problem1[random_index]
		var selected_value = problem_value1[random_index]
		get_value1.remove_at(random_index)
		get_value1.insert(random_index, problem_value1[random_index])
		print("Debug: the get_value1 list inserted another value of %s" % [selected_value] + "\nDebug: its given is/are %s" % [selected_given])
		print("Debug: the value it inserted in %s" % [selected_value] + "\nDebug: at random index: %s" % [random_index])
	
		problem_value1.remove_at(random_index)
		

		animation_label.text = "You got: %s" % [selected_given] + "\n Value: %s" % [selected_value]
		

		print("Debug: The list get_value1 var are: %s" % [get_value1])
		print("Debug: %s interacted with. Got '%s'. Remaining: %s" % [chest_name, selected_value, problem1])
	else:
		print("Debug: There are no more chests formulas left")

func refresh_panel() -> void:
	
	pass
