extends Control

var API_KEY = "AIzaSyA-7ATta01pzZGS7xboRiqr4yrCYrWkWN4"
var base_url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + API_KEY

@onready var http_request = $HTTPRequest

func _on_button_pressed() -> void:
	var json_data = {
		"email": $VBoxContainer/username.text,
		"password": $VBoxContainer/password.text,
		"returnSecureToken": true
	}
	
	http_request.request(base_url, [], HTTPClient.METHOD_POST, JSON.stringify(json_data))


func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response_data = body.get_string_from_utf8()
	# Get user data here
	var json_response = JSON.parse_string(response_data)
	
	# If response is ok
	if (response_code == 200):
		#ser authenticated
		print("Authenthication Succesful")
		$VBoxContainer/FeedbackText.text = "Authenthication Succesful"
		
		var timer = Timer.new()
		timer.wait_time = 2.0 #Set a 2-second delay
		timer.one_shot = true
		add_child(timer)
		timer.start()
		
		get_tree().change_scene_to_file("res://Scenes/Home.tscn")
		
	else:
		# Failed to authenticate
		$VBoxContainer/FeedbackText.text = json_response["error"]["message"]

func _on_sign_up_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rus_commit/scenes/sign_up.tscn")
