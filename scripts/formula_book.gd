extends Control

var formulas = [
	{"image": preload("res://assets/assets/Formulas/1.png")},
	{"image": preload("res://assets/assets/Formulas/2.png")},
	{"image": preload("res://assets/assets/Formulas/3.png")},
	{"image": preload("res://assets/assets/Formulas/4.png")},
	{"image": preload("res://assets/assets/Formulas/5.png")},
	{"image": preload("res://assets/assets/Formulas/6.png")},
	{"image": preload("res://assets/assets/Formulas/7.png")},
	{"image": preload("res://assets/assets/Formulas/8.png")},
	{"image": preload("res://assets/assets/Formulas/9.png")},
	{"image": preload("res://assets/assets/Formulas/10.png")}
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
	update_page()


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
	return not $page1.visible  # Return whether the panel is visible


func _on_texture_button_pressed() -> void:
	if $page1.visible == true:
		$page1.visible = false
		resume()
	elif $page1.visible == false:
		$page1.visible = true
		pause()


func update_page():
	# Disable buttons if needed

		
	back_button.disabled = current_page == 0
	next_button.disabled = current_page == formulas.size() - 1

	# Update content
	texture_rect.texture = formulas[current_page]["image"]

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
	if current_page < formulas.size() - 1:
		await slide_out(true)  # Slide out first
		current_page += 1
		update_page()  # Update page content
		await slide_in(true)  # Then slide in
