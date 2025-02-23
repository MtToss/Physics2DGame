extends Node

var http_request
const FIREBASE_URL = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/SCORE"
var document_id = ""  

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)  
	http_request.request_completed.connect(_on_http_request_completed)

# Record game session start time with user ID
func record_time_score(user_id: String):
	var start_time = int(Time.get_unix_time_from_system())  # Ensure integer timestamp
	var timestamp_value = {"seconds": start_time, "nanos": 0}  # Firestore format

	var url = FIREBASE_URL  # Firestore collection URL
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"user_id": {"stringValue": user_id}, 
			"timescore_chapter1": {"timestampValue": timestamp_value}
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_string)

	if error != OK:
		print("Request failed with error code:", error)
	else:
		print("Time score request sent successfully!")

# Generic function to update a chapter without removing previous data
func update_chapter_time(chapter: int):
	if document_id == "":
		print("Error: No document ID found. Make sure record_time_score() runs first.")
		return
	
	var chapter_time = int(Time.get_unix_time_from_system())
	var timestamp_value = {"seconds": chapter_time, "nanos": 0}  # Firestore format

	# Ensure the update only modifies the specified chapter, preventing deletion of others
	var url = FIREBASE_URL + "/" + document_id + "?updateMask.fieldPaths=timescore_chapter" + str(chapter)
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			("timescore_chapter" + str(chapter)): {"timestampValue": timestamp_value}
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_PATCH, json_string)

	if error != OK:
		print("Update request failed with error code:", error)
	else:
		print("Chapter", chapter, "update request sent successfully!")

# Update each chapter with correct function
func update_chapter_2():
	update_chapter_time(2)

func update_chapter_3():
	update_chapter_time(3)

func update_chapter_4():
	update_chapter_time(4)

# Firestore response handler
func _on_http_request_completed(result, response_code, headers, body):
	print("Response Code:", response_code)
	var response_text = body.get_string_from_utf8()
	print("Response Body:", response_text)

	if response_code == 200 or response_code == 201:
		var response_json = JSON.parse_string(response_text)
		if response_json and response_json.has("name") and response_json["name"] is String:
			document_id = response_json["name"].split("/")[-1]  # Extract Firestore document ID
			print("Document created with ID:", document_id)
		else:
			print("Unexpected response format:", response_json)
	else:
		print("Error storing data:", response_code, response_text)
