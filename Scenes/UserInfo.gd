extends Spatial


var username = "Dragon20C"
var level = 0
var team
var current_weapon = "AK47"
onready var TeamName = get_node("../../Menu/DebugTeam/TeamName")
onready var Weapon_name = get_node("../GameHUD/PlayerBoard/WeaponName")

func _process(delta):
	pass
#		if Input.is_action_just_pressed("Primary"):
#		current_weapon = "AK47"
#	elif Input.is_action_just_pressed("secondary"):
#		current_weapon = "Glock 18"
#	elif Input.is_action_just_released("tertiary"):
#		current_weapon = "AWP"
#	if Weapon_name == null:
#		pass
#	else:
#		Weapon_name.set_text(current_weapon)

func _on_RedTeam_Join_pressed():
	team = "red"
	TeamName.set_text(team)

func _on_BlueTeam_Join_pressed():
	team = "blue"
	TeamName.set_text(team)
