extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$PanelContainer/Panel/VBoxContainer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	test_esc()

func resume():
	get_tree().paused = false
	$PanelContainer/Panel/VBoxContainer.visible = false



func blur():
	$AnimationPlayer.play("blur")


func backwards_blur():
	$AnimationPlayer.play_backwards("blur")

func pause():
	var game_chapter = get_tree().current_scene  # Try to get the root scene
	if game_chapter:
		game_chapter.pause_by_pause_menu()
	get_tree().paused = true
	$PanelContainer/Panel/VBoxContainer.visible = true


func test_esc():
	var game_chapter = get_tree().current_scene  # Try to get the root scene
	
	var form_book = game_chapter.get_node_or_null("formula_book")
	
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		if game_chapter:
			game_chapter.hideorshow_panels()
		pause()
		blur()
		print("Debug: Game Paused")
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true and self.visible : #add to this elif the condition that the pause_menu scene where this code is in is not visible
		if game_chapter:
			game_chapter.hideorshow_panels()
		resume()
		backwards_blur()
		print("Debug: Game Resumed")

func _on_resume_pressed() -> void:
	resume()
	backwards_blur()

func _on_restart_pressed() -> void:
	var dialogue_scene = get_tree().get_nodes_in_group("dialogue")  # Ensure your dialogue scene is in a group
	if dialogue_scene.size() > 0:
		dialogue_scene[0].visible = false  # Hide dialogue UI
		
	resume()
	backwards_blur()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
