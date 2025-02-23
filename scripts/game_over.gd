extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/TextureRect.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func blur():
	$AnimationPlayer.play("blur")

func pause():
	get_tree().paused = true
	$Panel/TextureRect.visible = true

func showup():
	print("Debug: game over")
	pause()
	blur()
	
func _on_retry_pressed() -> void:
	var current_scene_path: String = get_tree().current_scene.scene_file_path
	
	if current_scene_path.begins_with("res://scenes/2-Player/"):
		get_tree().change_scene_to_file("res://scenes/2-Player/game_chapter_1.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/game_chapter_1.tscn")


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
