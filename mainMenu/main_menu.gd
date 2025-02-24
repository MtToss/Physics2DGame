extends Control

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_chapter_1.tscn")


func _on_how_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/2-Player/game_chapter_1.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://mainMenu/setting_scene.tscn")
	
