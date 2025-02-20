extends Control

var API_KEY = "AIzaSyDNEVsLGX-T-7bea8jitDou-BZRROoeoeA"
var signup_url = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + API_KEY
var firestore_url = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/USER"

@onready var http_request = $HTTPRequest

func _on_button_pressed() -> void:
	var json_data = {
		"email": $VBoxContainer2/email.text,
		"password": $VBoxContainer2/password.text,
		"returnSecureToken": true
	}
	
	http_request.request(signup_url, [], HTTPClient.METHOD_POST, JSON.stringify(json_data))

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response_data = body.get_string_from_utf8()
	var json_response = JSON.parse_string(response_data)

	if response_code == 200:
		# Signup was successful, proceed to store user data in Firestore
		if json_response.has("localId"):  # Check if 'localId' exists in the response
			var user_id = json_response["localId"]  # Firebase returns a unique user ID
			store_user_in_firestore(user_id)
		else:
			$VBoxContainer/FeedbackText.text = "Error: User ID not found in response."
	else:
		# Handle errors during signup
		if json_response and json_response.has("error"):
			var error_message = json_response["error"]["message"]
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
			
	

func store_user_in_firestore(user_id: String) -> void:
	var user_data = {
		"fields": {
			"full_name": {"stringValue": $VBoxContainer2/full_name.text},
			"username": {"stringValue": $VBoxContainer2/username.text},
			"email": {"stringValue": $VBoxContainer2/email.text},
			"user_id": {"stringValue": user_id},
			"created_at": {"timestampValue": {"seconds": int(Time.get_unix_time_from_system())}} 
		}
	}

	# Make Firestore request
	var firestore_headers = ["Content-Type: application/json"]
	var firestore_request_data = JSON.stringify(user_data)
	http_request.request(firestore_url, firestore_headers, HTTPClient.METHOD_POST, firestore_request_data)

func _on_firestore_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200 or response_code == 201:
		$VBoxContainer/FeedbackText.text = "User Registered"
	else:
		var error_message = body.get_string_from_utf8()
		$VBoxContainer/FeedbackText.text = "Failed to save user to Firestore: " + error_message
