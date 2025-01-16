extends Control



func _on_login_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rus_commit/scenes/login.tscn")

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_chapter_1.tscn")



func _on_sign_up_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rus_commit/scenes/sign_up.tscn")
