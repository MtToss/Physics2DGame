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

func _on_quit_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
