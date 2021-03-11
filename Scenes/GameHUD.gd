extends CanvasLayer

onready var time_label = $Scoreboard/CenterContainer/Time
onready var CrossHairAnimation = $CrossHair/CenterContainer/CenterContainer/CrossHairBlender
var minute = 8
var seconds = 0
var game_started = true
var start_count_down = 15
var menu = false
var settings = false
var mouse_focus = false
onready var fov_info = get_node("Video/FOV").get_text()
onready var fov_slider = get_node("Video/FOV_Slider")

func _process(delta):
	#Mouse Focus & Menu controls#
	if menu:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_just_pressed("ui_cancel"):
		menu = !menu
		
	if menu and $Settings.visible != true and $Video.visible != true:
		$Menu.visible = true
	elif menu == false:
		$Menu.visible = false
		$Settings.visible = false
	
	#Match Time#
	seconds = clamp(seconds,0,60)
	time_label.set_text(str(int(minute)) + ":" + str(int(seconds)))
	if game_started:
		if seconds == 0:
			minute -= 1
			seconds = 60
		elif seconds != 0:
			seconds -= 1 * delta
	#CrossHair#
	if Input.is_action_pressed("Aiming"):
		CrossHairAnimation.set("parameters/Crosshair/current",0)
	elif Input.is_action_pressed("w") or Input.is_action_pressed("a") or Input.is_action_pressed("s") or Input.is_action_pressed("d") and !Input.is_action_pressed("Aiming"):
		CrossHairAnimation.set("parameters/Crosshair/current",2)
	else:
		CrossHairAnimation.set("parameters/Crosshair/current",1)
		
	if menu or $Settings.visible == true or $Video.visible == true:
		$CrossHair.visible = false
	else:
		$CrossHair.visible = true
func _on_Exit_pressed():
	get_tree().change_scene("res://Menu/MenuLayer.tscn")
	
func _on_Settings_pressed():
	$Settings.visible = true
	$Menu.visible = false
func _on_Create_a_class_pressed():
	pass
func _on_Leave_pressed():
	$Settings.visible = false
	$Video.visible = false
func _on_Video_pressed():
	$Video.visible = true
	$Settings.visible = false
