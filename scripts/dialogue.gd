extends Control

var is_typing = false
var index: int = 0
var dialogue: Array = []  # Example array for storing dialogue lines
var typing_speed: float = 0.0005  # Example speed value
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func resume():
	get_tree().paused = false
	$Panel.visible = false
	$skip.visible = false
	set_process_input(false)  # Disable _input() when the panel is hidden


#func blur():
#	$AnimationPlayer.play("blur")


#func backwards_blur():
#	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$Panel.visible = true
	$skip.visible = true
	set_process_input(true)  # Enable _input() when the panel is shown

func set_dialogue(new_dialogue: Array) -> void:
	dialogue = new_dialogue

func show_typing_effect(text: String, speed: float) -> void:
	is_typing = true 
	$Panel/dialogue_panel.text = ""  
	for i in range(text.length()):
		$Panel/dialogue_panel.text += text[i]
		await get_tree().create_timer(speed).timeout  
	is_typing = false

func play_scene() -> void:
	if index < dialogue.size():  
		if !is_typing:  
			await show_typing_effect(dialogue[index], typing_speed) 
			index += 1 
			
			print('play scene')
			
		else:
			print("Already typing, please wait.")
	else:	
		print("Debug: Game Resumed")
		resume()


func _on_button_pressed() -> void:
	print("button pressed")
	resume()
	

func _input(event: InputEvent) -> void:
	# Only handle clicks that aren't on the button
	if event is InputEventMouseButton and event.pressed:
		# Check if the click is not on the button (adjust the condition as needed)
		if !$skip.get_global_rect().has_point(event.position):
			if !is_typing:
				print('play')
				play_scene()
				return
		else:
			resume()
