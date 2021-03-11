extends Spatial

onready var player = preload("res://Scenes/Player.tscn")

var blue_team_max
var blue_team = []
var blue_loop = 0
onready var blue_spatial = $Control/TeamController/Blue

var red_team_max
var red_team = []
var red_loop = 0
onready var red_spatial = $Control/TeamController/Red

func _ready():
	randomize()
	
	blue_team_max = blue_spatial.get_child_count()
	if blue_loop != blue_team_max:
		for i in blue_spatial.get_children():
			blue_team.append(i)
			blue_loop += 1
	print(blue_team)
	
	red_team_max = red_spatial.get_child_count()
	if red_loop != red_team_max:
		for i in red_spatial.get_children():
			red_team.append(i)
			red_loop += 1
	print(red_team)
func _process(delta):
	pass


func _on_JoinBlue_pressed():
	var blue_selection = blue_team[randi() % blue_team.size()]
	var player_spawn = player.instance()
	add_child(player_spawn)
	player_spawn.transform.origin = blue_selection.transform.origin
func _on_JoinRed_pressed():
	var red_selection = red_team[randi() % red_team.size()]
