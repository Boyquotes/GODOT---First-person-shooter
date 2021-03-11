extends Spatial


onready var dropdown_menu = $OptionButton

func add_items():
	dropdown_menu.add_item("Map 1")
	dropdown_menu.add_item("Map 2")
	dropdown_menu.add_item("Map 3")
	dropdown_menu.add_item("Map 4")

func _ready():
	add_items()
func _process(delta):
	if dropdown_menu.selected == 0:
		pass

func _on_Multiplayer_pressed():
	pass # Replace with function body.


func _on_CustomGame_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
