extends Node

var http_request = HTTPRequest.new()
const FIREBASE_URL = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/GAME_SESSION"
var document_id = "psmIJTBtZI31LI4QRjiT"  

func _ready():
	add_child(http_request)  
	http_request.request_completed.connect(_on_http_request_request_completed)
	store_start_time

func store_start_time(name: String, age: int):
	var start_time = int(Time.get_unix_time_from_system())  # Ensure timestamp is an integer
	
	var url = FIREBASE_URL  # Collection URL
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"start_time": {"timestampValue": {"seconds": start_time}}  # Use integer value
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_string)

	if error != OK:
		print("Request failed with error code:", error)
	else:
		print("Start time stored successfully!")


func store_end_time():
	if document_id == "":
		print("Error: No document ID found! End time cannot be stored.")
		return

	var end_time = int(Time.get_unix_time_from_system())  # Ensure timestamp is an integer
	
	print("Debug: Storing end time -", end_time, "for document:", document_id)

	var url = FIREBASE_URL + "/" + document_id
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"end_time": {"timestampValue": {"seconds": end_time}}  # Use integer value
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_PATCH, json_string)

	if error != OK:
		print("Error: Request failed with code:", error)
	else:
		print("Debug: End time stored successfully!")

# Handle Firestore response
func _on_http_request_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response_json = JSON.parse_string(body.get_string_from_utf8())
		if "name" in response_json:
			document_id = response_json["name"].split("/")[-1]  # Extract Firestore document ID
			print("Document created with ID:", document_id)
	else:
		print("Error storing data:", response_code, body.get_string_from_utf8())
