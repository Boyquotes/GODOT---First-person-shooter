extends Control

var opened = false

func _process(delta):
	if Input.is_action_just_pressed("tab"):
		opened = !opened
		
	if opened:
		visible = true
	else:
		visible = false
