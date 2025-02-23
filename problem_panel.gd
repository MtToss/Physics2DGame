extends Control


@onready var line_edit = $Panel/LineEdit
var correct_answer: int = 42
var user_input: int
signal answer_submitted(user_input: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_edit.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_line_edit_text_submitted(new_text: String) -> void:
	print("Entered: ", new_text)
	user_input = new_text.to_float()

	var decision: bool = (user_input == correct_answer)
	emit_signal("answer_submitted", user_input)
	print("Debug: Signal emitted with value ", user_input)
	
	if decision:
		line_edit.text = "" 
		print("Debug: korique")
	else:
		print("Incorrect answer. Try again.")
