extends Control




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resume():
	get_tree().paused = false


func pause():
	var game_chapter = get_tree().current_scene  # Try to get the root scene
	if game_chapter:
		game_chapter.pause_by_formula_button()
	get_tree().paused = true

func formulaPanel_checker() -> bool:
	return not $Panel.visible  # Return whether the panel is visible


func _on_texture_button_pressed() -> void:
	if $Panel.visible == true:
		$Panel.visible = false
		resume()
	elif $Panel.visible == false:
		$Panel.visible = true
		pause()
