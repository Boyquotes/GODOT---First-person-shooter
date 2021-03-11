extends Control

onready var userinfo = $UserInfo/

func _process(delta):
	$HealthAndStamina/Username.set_text(userinfo.username)
	
