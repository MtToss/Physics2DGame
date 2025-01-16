extends Node2D

@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D

@onready var animation_player = $ENUMAN/Camera2D/Animation/AnimationPlayer
@onready var animation_label = $ENUMAN/Camera2D/Animation/Control/Label

var problem1 = ["force", "speed", "angle"]


	
func _ready() -> void:
	pass


	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	interact_chess()
	pass

func interact_chess() -> void:
	if label1.visible and Input.is_action_just_pressed("interact"):
		chest1._open_chest()
		interact_with_chest("chest1")
		animation_player.play_slide()
	
	if label2.visible and Input.is_action_just_pressed("interact"):
		chest2._open_chest()
		interact_with_chest("chest2")
		animation_player.play_slide()

func interact_with_chest(chest_name: String) -> void:
	if problem1.size() > 0:

		var random_index = randi() % problem1.size()
		var selected_value = problem1[random_index]

		problem1.remove_at(random_index)


		animation_label.text = "You got: %s" % [selected_value]


		print("Debug: %s interacted with. Got '%s'. Remaining: %s" % [chest_name, selected_value, problem1])
	else:
		print("Debug: There are no more chests formulas left")
