extends Control

var menu_transition_time = 0.5

var menu_origin_position = Vector2.ZERO
var menu_origin_size = Vector2.ZERO

var current_menu
var menu_stack = []
export (Resource) var map1
export (Resource) var map2
export (Resource) var map3
export (Resource) var map4
export (Resource) var map5
export (Resource) var map6
onready var menu_1 = $MainMenu
onready var menu_2 = $"Custom Classes"
onready var settings = $Settings
onready var customgame = $CustomGames
onready var multiplayer_menu = $Multiplayer
onready var tween = $Tween
onready var map_option = $CustomGames/CenterContainer/Splitter/VBoxContainer2/Mapoption
onready var Map_Picture = $CustomGames/Map_Picture
onready var map_images = [map1,map2,map3,map4,map5,map6]
func _ready():
	menu_origin_position = Vector2(0,0)
	menu_origin_size = get_viewport_rect().size
	current_menu = menu_1
func _process(delta):
	if map_option.selected == 0:
		Map_Picture.set_texture(map_images[0])
	elif map_option.selected == 1:
		Map_Picture.set_texture(map_images[1])
	elif map_option.selected == 2:
		Map_Picture.set_texture(map_images[2])
	elif map_option.selected == 3:
		Map_Picture.set_texture(map_images[3])
	elif map_option.selected == 4:
		Map_Picture.set_texture(map_images[4])
	elif map_option.selected == 5:
		Map_Picture.set_texture(map_images[5])

func move_to_next_menu(next_menu_id : String):
	var next_menu = get_menu_from_menu_id(next_menu_id)
	#current_menu.rect_global_position = Vector2(-menu_origin_size.x,0)
	#next_menu.rect_global_position = menu_origin_position
	tween.interpolate_property(current_menu,"rect_global_position",current_menu.rect_global_position,Vector2(-menu_origin_size.x,0),menu_transition_time)
	tween.interpolate_property(next_menu,"rect_global_position",next_menu.rect_global_position,menu_origin_position,menu_transition_time)
	tween.start()
	menu_stack.append(current_menu)
	current_menu = next_menu
	
func move_to_previous_menu():
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		#previous_menu.rect_global_position = menu_origin_position
		#current_menu.rect_global_position = Vector2(menu_origin_size.x,0)
		tween.interpolate_property(previous_menu,"rect_global_position",previous_menu.rect_global_position,menu_origin_position,menu_transition_time)
		tween.interpolate_property(current_menu,"rect_global_position",current_menu.rect_global_position,Vector2(menu_origin_size.x,0),menu_transition_time)
		tween.start()
		current_menu = previous_menu

func get_menu_from_menu_id(menu_id : String):
	match menu_id:
		"menu_1":
			return menu_1
		"menu_2":
			return menu_2
		"settings":
			return settings
		"customgames":
			return customgame
		"multiplayer":
			return multiplayer_menu
		_:
			return menu_1


func _on_Custom_Games_pressed():
	move_to_next_menu("customgames")
	
func _on_Back_pressed():
	move_to_previous_menu()
	
func _on_Settings_pressed():
	move_to_next_menu("settings")
	
func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Create_a_class_pressed():
	move_to_next_menu("menu_2")

func _on_Multiplayer_pressed():
	move_to_next_menu("multiplayer")



func _on_Play_pressed():
	if map_option.selected == 0:
		get_tree().change_scene("res://Models/Maps/Map 1/Map 1.tscn")
	elif map_option.selected == 1:
		get_tree().change_scene("res://Models/Maps/Map 2/Map2.tscn")
	elif map_option.selected == 2:
		get_tree().change_scene("res://Models/Maps/Map 3/ShootingRange.tscn")
	elif map_option.selected == 3:
		get_tree().change_scene("res://Models/Maps/Map 4/Map 4.tscn")
	elif map_option.selected == 4:
		get_tree().change_scene("res://Models/Maps/Map 5/Map 5.tscn")
	elif map_option.selected == 5:
		get_tree().change_scene("res://Models/Maps/Map 6/Map 6.tscn")
