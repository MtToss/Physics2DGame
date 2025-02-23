extends Node

var http_request
const FIREBASE_URL = "https://firestore.googleapis.com/v1/projects/enyumandb/databases/(default)/documents/LEADERBOARD"

func _ready():
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_completed)

	# Fetch time score data when the game starts
	fetch_time_scores()

# Fetch all documents from Firestore collection "SCORE"
func fetch_time_scores():
	var url = FIREBASE_URL  # Firestore collection URL
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(url, headers, HTTPClient.METHOD_GET)

	if error != OK:
		print("Request failed with error code:", error)
	else:
		print("Fetching time scores...")

# Handle Firestore response
func _on_http_request_completed(result, response_code, headers, body):
	print("Response Code:", response_code)
	var response_text = body.get_string_from_utf8()
	print("Response Body:", response_text)

	if response_code == 200:
		var response_json = JSON.parse_string(response_text)
		if response_json and response_json.has("documents"):
			for doc in response_json["documents"]:
				if doc.has("fields") and doc["fields"].has("start_time"):
					var timestamp = doc["fields"]["start_time"]["timestampValue"]["seconds"]
					convert_and_print_time(timestamp)
		else:
			print("No documents found in SCORE collection.")
	else:
		print("Error fetching data:", response_code, response_text)

# Convert Unix timestamp to minutes and seconds
func convert_and_print_time(timestamp: int):
	var elapsed_time = Time.get_unix_time_from_system() - timestamp
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60

	print("Time Score: %d minutes, %d seconds" % [minutes, seconds])
