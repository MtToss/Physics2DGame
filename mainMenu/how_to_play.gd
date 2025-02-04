extends Control

# Tutorial data
var tutorial_pages = [
	{"image": preload("res://mainMenu/image_1.png")},
	{"image": preload("res://mainMenu/image_2.jpg")},
	{"image": preload("res://mainMenu/image_3.png")}
]

# Current page index
var current_page = 0


# References to UI elements
@onready var texture_rect = $how/page1/TextureRect	
@onready var back_button = $how/back
@onready var next_button = $how/next	
@onready var animation_player = $how/page1/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_page()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	
func _on_back_pressed() -> void:
	if current_page > 0:
		await slide_out(false)  # Slide out first
		current_page -= 1
		update_page()  # Update page content
		await slide_in(false)  # Then slide in

func _on_next_pressed() -> void:
	if current_page < tutorial_pages.size() - 1:
		await slide_out(true)  # Slide out first
		current_page += 1
		update_page()  # Update page content
		await slide_in(true)  # Then slide in


func _on_main_back_pressed() -> void:
	get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")
