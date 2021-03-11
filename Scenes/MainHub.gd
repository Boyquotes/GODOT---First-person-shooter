extends Control
export (Resource) var map1
export (Resource) var map2
export (Resource) var map3
export (Resource) var map4
export (Resource) var map5
export (Resource) var map6
var weapons = []
var weapon_index = 0
var weapons_max = 0
onready var weapon_spatial = get_node("MainMenuRoom/WeaponHolder")
onready var camera_animation = $MainMenuRoom/Camera/CameraAnimation
onready var DropDownMapMenu = $Custom_Games/CenterContainer/VBoxContainer/Custom_Games
onready var Map_Picture = $Custom_Games/Map_Picture
onready var map_images = [map1, map2, map3, map4, map5, map6]

func _ready():
	for i in weapon_spatial.get_children():
		weapons.append(i)
	weapon_index = 0
	weapons[weapon_index].visible = true
	weapons_max = weapon_spatial.get_child_count()
func _process(delta):
	if DropDownMapMenu.selected == 0:
		Map_Picture.set_texture(map_images[0])
	elif DropDownMapMenu.selected == 1:
		Map_Picture.set_texture(map_images[1])
	elif DropDownMapMenu.selected == 2:
		Map_Picture.set_texture(map_images[2])
	elif DropDownMapMenu.selected == 3:
		Map_Picture.set_texture(map_images[3])
	elif DropDownMapMenu.selected == 4:
		Map_Picture.set_texture(map_images[4])
	elif DropDownMapMenu.selected == 5:
		Map_Picture.set_texture(map_images[5])
#Main
func _on_Multiplayer_pressed():
	pass # Replace with function body.


func _on_Custom_Games_pressed():
	$Main.visible = false
	$Custom_Games.visible = true
	
func _on_Settings_pressed():
	$Settings.visible = true
	$Main.visible = false

func _on_Quit_pressed():
	get_tree().quit()
#Main
#Settings
func _on_Leave_pressed():
	$Main.visible = true
	$Custom_Games.visible = false
	$Settings.visible = false


func _on_Play_pressed():
	if DropDownMapMenu.selected == 0:
		get_tree().change_scene("res://Models/Maps/Map 1/Map 1.tscn")
	elif DropDownMapMenu.selected == 1:
		get_tree().change_scene("res://Models/Maps/Map 2/Map2.tscn")
	elif DropDownMapMenu.selected == 2:
		get_tree().change_scene("res://Models/Maps/Map 3/ShootingRange.tscn")
	elif DropDownMapMenu.selected == 3:
		get_tree().change_scene("res://Models/Maps/Map 4/Map 4.tscn")
	elif DropDownMapMenu.selected == 4:
		get_tree().change_scene("res://Models/Maps/Map 5/Map 5.tscn")
	elif DropDownMapMenu.selected == 5:
		get_tree().change_scene("res://Models/Maps/Map 6/Map 6.tscn")


func _on_Create_A_Class_pressed():
	camera_animation.play("Create_a_class")
	$Main.visible = false
	yield(get_tree().create_timer(1.65), "timeout")
	$Create_A_Class.visible = true


func _on_Back_pressed():
	if weapon_index > 0:
		weapons[weapon_index].visible = false
		weapon_index -= 1
		weapons[weapon_index].visible = true

func _on_Next_pressed():
	if weapon_index < weapons_max -1:
		weapons[weapon_index].visible = false
		weapon_index += 1
		weapons[weapon_index].visible = true


func _on_Back_to_menu_pressed():
	$Create_A_Class.visible = false
	camera_animation.play("Back_to_menu")
	yield(get_tree().create_timer(1.65), "timeout")
	$Main.visible = true
