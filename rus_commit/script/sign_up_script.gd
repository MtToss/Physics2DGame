extends Control

var API_KEY = "AIzaSyA-7ATta01pzZGS7xboRiqr4yrCYrWkWN4"
var base_url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + API_KEY

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
		print("Sign up successful")
		$VBoxContainer/FeedbackText.text = "Sign up successful"
	else:
		# Failed to authenticate, check for specific error
		if json_response.error:
			var error_message = json_response.error.message
			match error_message:
				"EMAIL_EXISTS":
					$VBoxContainer/FeedbackText.text = "This email is already in use."
				"INVALID_EMAIL":
					$VBoxContainer/FeedbackText.text = "Invalid email format."
				"WEAK_PASSWORD":
					$VBoxContainer/FeedbackText.text = "Password is too weak."
				_:
					$VBoxContainer/FeedbackText.text = "Authentication failed: " + error_message
		else:
			$VBoxContainer/FeedbackText.text = "Unexpected error occurred."


func _on_log_in_button_pressed() -> void:
	get_tree().change_scene_to_file("res://rus_commit/scenes/login.tscn")
