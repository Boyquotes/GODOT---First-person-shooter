extends Node2D

var menu = false
		
func _process(delta):
		if Input.is_action_just_pressed("ui_cancel"):
			menu = !menu
		if menu == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$CanvasLayer/Exit.visible = true
			$CanvasLayer/Create_A_Class.visible = true
			$CanvasLayer/Settings.visible = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$CanvasLayer/Exit.visible = false
			$CanvasLayer/Create_A_Class.visible = false
			$CanvasLayer/Settings.visible = false


func _on_Quit_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Create_A_Class_pressed():
	pass # Replace with function body.


func _on_Settings_pressed():
	pass # Replace with function body.
