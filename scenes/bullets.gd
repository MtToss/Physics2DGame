extends Area2D

var speed = 300
var direction = 1

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position.x -= speed * direction * delta
