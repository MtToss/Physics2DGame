extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	test_esc()

func resume():
	get_tree().paused = false


func blur():
	$AnimationPlayer.play("blur")

func backwards_blur():
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true


func test_esc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
		blur()
		print("Debug: Game Paused")
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()
		backwards_blur()
		print("Debug: Game Resumed")

func _on_resume_pressed() -> void:
	resume()
	backwards_blur()

func _on_restart_pressed() -> void:
	resume()
	backwards_blur()
	get_tree().reload_current_scene()

#func _on_quit_pressed() -> void:
#	resume()
#	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")

func _on_quit_pressed() -> void:
	print("Debug: Quit button pressed.")
	
	var firebase = get_node("/root/FirebaseManager")  # Ensure this matches the Firebase node path

	if not firebase:
		print("Error: Firebase not found!")
		return
	
	print("Debug: Calling Firebase.store_end_time()...")
	firebase.store_end_time() 
	
	print("Debug: Waiting 1 second before quitting...")
	await get_tree().create_timer(1.0).timeout  # Ensure request is sent
	
	print("Debug: Back to Menu")
	resume()
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
