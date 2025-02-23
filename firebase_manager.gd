extends Node

var http_request = HTTPRequest.new()
const FIREBASE_URL = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/GAME_SESSION"
var document_id = ""  # Store Firestore document ID

func _ready():
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_request_completed)

# Store game session start time with user ID
func store_start_time(user_id: String):
	var start_time = int(Time.get_unix_time_from_system())  # Ensure timestamp is an integer

	var url = FIREBASE_URL  # Firestore collection URL
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"user_id": {"stringValue": user_id},  # Store user_id
			"start_time": {"timestampValue": {"seconds": start_time}}
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_string)

	if error != OK:
		print("Request failed with error code:", error)
	else:
		print("Start time stored successfully!")


# Store game session end time (check if end_time is null before storing)
func store_end_time():
	if document_id == "":
		print("Error: No document ID found! End time cannot be stored.")
		return

	# Check if end_time is null (it could mean an incomplete session)
	var url = FIREBASE_URL + "/" + document_id  # Firestore document path
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)  # GET request to check if end_time exists

	if error != OK:
		print("Error: Failed to retrieve document for end_time check.")
		return
	
	http_request.request_completed.connect(_on_end_time_check_completed)

# Handle Firestore response for the GET request to check end_time
func _on_end_time_check_completed(result, response_code, headers, body):
	if response_code == 200:
		var response_json = JSON.parse_string(body.get_string_from_utf8())
		var fields = response_json.get("fields", {})
		var end_time = fields.get("end_time", null)
		
		if end_time == null:
			print("Error: end_time is null, skipping data submission.")
			return  # Skip sending the end time if it's null (or user pressed quit)
		else:
			print("Debug: Storing end time -", end_time, "for document:", document_id)
			_patch_end_time(end_time)
	else:
		print("Error: Failed to retrieve document details:", response_code)

# Patch end time into Firestore
func _patch_end_time(end_time: int):
	var url = FIREBASE_URL + "/" + document_id
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"end_time": {"timestampValue": {"seconds": end_time}}
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_PATCH, json_string)

	if error != OK:
		print("Error: Request failed with code:", error)
	else:
		print("Debug: End time stored successfully!")

# Delete the game session document from Firestore (if end_time is null or user presses quit)
func delete_document():
	if document_id == "":
		print("Error: No document ID found! Cannot delete session.")
		return

	# Don't attempt to send data if user pressed quit or session is incomplete
	var url = FIREBASE_URL + "/" + document_id  # Firestore document path
	var headers = ["Content-Type: application/json"]

	print("Debug: Deleting game session document:", document_id)

	var error = http_request.request(url, headers, HTTPClient.METHOD_DELETE)  # DELETE request

	if error != OK:
		print("Error: Request failed with code:", error)
	else:
		print("Debug: Game session document deleted successfully!")

# Handle Firestore response
func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response_json = JSON.parse_string(body.get_string_from_utf8())
		if "name" in response_json:
			document_id = response_json["name"].split("/")[-1]  # Extract Firestore document ID
			print("Document for Game Session created with ID:", document_id)
	else:
		print("Error storing data:", response_code, body.get_string_from_utf8())
