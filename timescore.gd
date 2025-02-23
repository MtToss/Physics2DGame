extends Node

var http_request
const FIREBASE_URL = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/SCORE"
var document_id = ""  
var stopwatch: Stopwatch  # Reference to stopwatch

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)  
	http_request.request_completed.connect(_on_http_request_completed)

# Link stopwatch instance
func set_stopwatch(sw: Stopwatch):
	stopwatch = sw

# Record game session start time
func record_time_score(user_id: String):
	var start_time = int(Time.get_unix_time_from_system())  
	var timestamp_value = {"seconds": start_time, "nanos": 0}  

	var url = FIREBASE_URL  
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

# Store stopwatch time when scene changes
func record_stopwatch_time(chapter: int):
	if document_id == "":
		print("Error: No document ID found.")
		return
	
	var stopwatch_time = stopwatch.get_time() if stopwatch else {"minutes": 0, "seconds": 0}

	var url = FIREBASE_URL + "/" + document_id
	var headers = ["Content-Type: application/json"]
	var data = {
		"fields": {
			"timescore_chapter%d" % chapter: {
				"mapValue": {
					"fields": {
						"minutes": {"integerValue": stopwatch_time["minutes"]},
						"seconds": {"integerValue": stopwatch_time["seconds"]}
					}
				}
			}
		}
	}

	var json_string = JSON.stringify(data)
	var error = http_request.request(url, headers, HTTPClient.METHOD_PATCH, json_string)

	if error != OK:
		print("Update request failed with error code:", error)
	else:
		print("Stopwatch time recorded for Chapter", chapter)

func _on_http_request_completed(result, response_code, headers, body):
	print("Response Code:", response_code)
	var response_text = body.get_string_from_utf8()
	print("Response Body:", response_text)

	if response_code == 200 or response_code == 201:
		var response_json = JSON.parse_string(response_text)
		if response_json and response_json.has("name") and response_json["name"] is String:
			document_id = response_json["name"].split("/")[-1]  
			print("Document created with ID:", document_id)
		else:
			print("Unexpected response format:", response_json)
	else:
		print("Error storing data:", response_code, response_text)
