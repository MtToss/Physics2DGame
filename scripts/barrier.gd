extends Node2D

var disable: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func disable_barrier() -> void:
	if disable:
		var static_body = $StaticBody2D if has_node("StaticBody2D") else null
		var sprite = $AnimatedSprite2D if has_node("AnimatedSprite2D") else null

		if is_instance_valid(static_body):
			static_body.queue_free()

		if is_instance_valid(sprite):
			sprite.queue_free()

func _process(delta: float) -> void:
	pass
