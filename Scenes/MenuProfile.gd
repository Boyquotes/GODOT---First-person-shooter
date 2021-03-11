extends Control

onready var userinfo = get_node("UserInfo")
func _process(delta):
	$CenterContainer/VBoxContainer/Username.set_text(userinfo.username)
	$CenterContainer/VBoxContainer/Level.set_text(str(userinfo.level))
