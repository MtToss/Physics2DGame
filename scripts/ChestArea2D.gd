extends Area2D

var is_chest_opened = false


func _ready() -> void:
	$Label.hide()

	self.connect("body_entered", Callable(self, "_on_area2d_body_entered"))
	self.connect("body_exited", Callable(self, "_on_area2d_body_exited"))

func _on_area2d_body_entered(body):
	if body.name == "ENUMAN"  or (body.name == "Doggi" ):
		if is_chest_opened:
			$Label.hide()
			
		else:
			$Label.show()
func _on_area2d_body_exited(body):
	if body.name == "ENUMAN"  or (body.name == "Doggi" ):
		$Label.hide()

func hide_label():
	$Label.hide()

func _open_chest():
	$AnimatedSprite2D.play("opened chest") 
	
	is_chest_opened = true
	$Label.hide
	
func play():
	$AnimatedSprite2D.play("closed chest")

func stop():	
	$AnimatedSprite2D.stop()
	
	
