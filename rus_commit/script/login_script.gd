extends Control

var API_KEY = "AIzaSyDNEVsLGX-T-7bea8jitDou-BZRROoeoeA"
var base_url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + API_KEY

@onready var http_request = $HTTPRequest
@onready var email_field = $VBoxContainer/email
@onready var password_field = $VBoxContainer/password
@onready var feedback_text = $VBoxContainer/FeedbackText

var user_id = ""  

func _on_button_pressed() -> void:
	if not email_field or not password_field:
		print("Error: Email or Password field not found!")
		return

	var json_data = {
		"email": email_field.text,
		"password": password_field.text,
		"returnSecureToken": true
	}

	http_request.request(base_url, [], HTTPClient.METHOD_POST, JSON.stringify(json_data))

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var response_data = body.get_string_from_utf8()
	var json_response = JSON.parse_string(response_data)

	if response_code == 200:
		print("Authentication Successful")
		feedback_text.text = "Authentication Successful"

		# Store Firebase User ID
		user_id = json_response["localId"]
		print("User ID:", user_id)

		# Start the game session
		FirebaseManager.store_start_time(user_id)
		Timescore.record_time_score(user_id)
		# Delay scene change
		var timer = Timer.new()
		timer.wait_time = 2.0
		timer.one_shot = true
		add_child(timer)
		timer.timeout.connect(_change_scene)
		timer.start()
	else:
		feedback_text.text = json_response.get("error", {}).get("message", "Authentication Failed")

func _change_scene() -> void:
	print("Changing scene to Home.tscn...")
	var error = get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
	if error != OK:
		print("Error changing scene:", error)
