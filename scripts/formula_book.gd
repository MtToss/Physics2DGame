extends Control

var tutorial_pages = [
	{"image": preload("res://mainMenu/image_1.png")},
	{"image": preload("res://mainMenu/image_2.jpg")},
	{"image": preload("res://mainMenu/image_3.png")}
]

# Current page index
var current_page = 0


# References to UI elements
@onready var texture_rect = $page1/TextureRect
@onready var back_button = $page1/back
@onready var next_button = $page1/next
@onready var animation_player = $page1/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func resume():
	get_tree().paused = false


func pause():
	var game_chapter = get_tree().current_scene  # Try to get the root scene
	if game_chapter:
		game_chapter.pause_by_formula_button()
	get_tree().paused = true

func formulaPanel_checker() -> bool:
	return not $Panel.visible  # Return whether the panel is visible


func _on_texture_button_pressed() -> void:
	if $Panel.visible == true:
		$Panel.visible = false
		resume()
	elif $Panel.visible == false:
		$Panel.visible = true
		pause()


func update_page():
	# Disable buttons if needed

		
	back_button.disabled = current_page == 0
	next_button.disabled = current_page == tutorial_pages.size() - 1

	# Update content
	texture_rect.texture = tutorial_pages[current_page]["image"]

func slide_out(is_next: bool) -> void:
	if is_next:
		animation_player.play("slide_out")
	else:
		animation_player.play("next_slide_out")
	await animation_player.animation_finished 

func slide_in(is_next: bool) -> void:
	if is_next:
		animation_player.play("next_slide_in")
	else:
		animation_player.play("slide_in")
	await animation_player.animation_finished
