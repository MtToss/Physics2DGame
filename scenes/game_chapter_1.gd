extends Node2D

@onready var label1 = $chest1/Area2D/Label
@onready var label2 = $chest2/Area2D/Label

@onready var chest1 = $chest1/Area2D
@onready var chest2 = $chest2/Area2D

func _ready() -> void:
	print("GUMAGANA NGA ITO")# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process()
	pass

func process() -> void:
	if label1.visible and Input.is_action_just_pressed("interact"):
		chest1._open_chest()
	
	if label2.visible and Input.is_action_just_pressed("interact"):
		chest2._open_chest()
