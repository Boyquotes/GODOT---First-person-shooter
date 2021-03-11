extends Spatial

var menu = false
var mouse_move
var sway_threshold = 5
var sway_lerp = 5
var ADS_LERP = 12
var weapons = []
var weapon_loop = 0
var weapons_max
var weapon_index : int
var weapon_mode # "auto" or "single"
var rate_of_fire
var can_fire = true
var recoil_duration = 0
var damage
var index = 0
var recoil_damping = 0


#WeaponBobing
var speed = 8
var amplitude = 0.5
var time = 0
var is_bobing = true

onready var player = get_node("../../")
onready var head = get_node("../../Head")
onready var Weapon_name = get_node("../../GameHUD/PlayerBoard/WeaponName")
onready var hitmarker = get_node("../../GameHUD/HitMarker/HitMarkerPlayer")
onready var hitmarker_sound = get_node("../../HitMarker")
onready var gunline = get_node("../../Head/Camera/GunLine")

export var default_pos : Vector3
export var aim_pos : Vector3
export var sway_left : Vector3
export var sway_right : Vector3
export var sway_normal : Vector3

var max_ammo = 200
var max_mag_ammo = 30
var current_ammo = 30 # same as max
var difference = 0

func _ready():
	weapons_max = self.get_child_count()
	if weapon_loop != weapons_max:
		for i in self.get_children():
			weapons.append(i)
			weapons[weapon_loop].visible = false
			weapon_loop += 1
	weapon_index = 0
	weapons[weapon_index].visible = true
	
	max_ammo = weapons[weapon_index].max_ammo
	max_mag_ammo = weapons[weapon_index].max_mag_ammo
	current_ammo = weapons[weapon_index].current_ammo
	difference = 0
func _input(event):
	if event is InputEventMouseMotion:
		mouse_move = -event.relative.x
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		menu = !menu
	ADS_LERP = weapons[weapon_index].ads_speed
	damage = weapons[weapon_index].damage
	weapon_mode = weapons[weapon_index].mode
	rate_of_fire = weapons[weapon_index].rate_of_fire

	get_node("../../GameHUD/PlayerBoard/AmmoLabel").set_text(str(current_ammo) + " / " + str(int(max_ammo)))
	Weapon_name.set_text(weapons[weapon_index].weapon_name)
	if mouse_move != null:
		if mouse_move > sway_threshold and !Input.is_action_pressed("Aiming"):
			rotation = rotation.linear_interpolate(sway_left,sway_lerp * delta)
		elif mouse_move < -sway_threshold and !Input.is_action_pressed("Aiming"):
			rotation = rotation.linear_interpolate(sway_right,sway_lerp * delta)
		else:
			rotation = rotation.linear_interpolate(sway_normal,sway_lerp * delta)

func _physics_process(delta):

	head.rotation_degrees.x = clamp(head.rotation_degrees.x,-89,89)
	var frequency = speed
	var movement = cos(time*frequency)*amplitude
	if Input.is_action_pressed("sprint") and player.sprinting:
		speed = 14
		amplitude = 1
		$"AS VAL/AnimationPlayer".play("Sprint")
	else:
		speed = 8
		amplitude = 0.5
		
	if Input.is_action_pressed("w") and !Input.is_action_pressed("Aiming") and player.is_on_floor():
		transform.origin.x += movement * delta
		time += delta
	else:
		time = 0
		
	if Input.is_action_pressed("Aiming"):
		transform.origin = transform.origin.linear_interpolate(aim_pos,ADS_LERP * delta)
	else:
		transform.origin = transform.origin.linear_interpolate(default_pos,ADS_LERP * delta)
	
	if Input.is_action_just_pressed("Primary"):
		if weapon_index < weapons_max -1:
			weapons[weapon_index].visible = false
			weapon_index += 1
			weapons[weapon_index].visible = true
	if Input.is_action_just_pressed("secondary"):
		if weapon_index > 0:
			weapons[weapon_index].visible = false
			weapon_index -= 1
			weapons[weapon_index].visible = true
			
	if Input.is_action_just_pressed("reload") and max_ammo > 0 and current_ammo != max_mag_ammo:
		reload(weapons[weapon_index].reload_speed,weapons[weapon_index].reload_sound,weapons[weapon_index].animation)
		
	if weapon_mode == "auto":
		if Input.is_action_pressed("fire") and current_ammo != 0 and can_fire == true and !menu:
			firing()
			
	elif weapon_mode == "single":
		if Input.is_action_just_pressed("fire") and current_ammo != 0 and can_fire == true and !menu:
			firing()
	if index > len(weapons[weapon_index].RecoilPatternY) - 1 and recoil_duration > 0:
		index = 0
	
	if recoil_duration > 0:
		head.rotation_degrees.x += (weapons[weapon_index].RecoilPatternY[index] * delta) / 0.1
		player.rotation_degrees.y += weapons[weapon_index].RecoilPatternX[index] * delta / 0.1
		recoil_duration -= delta
	
	
	#####
	#if recoil_duration < 0 and !Input.is_action_pressed("fire"):
	#	head.rotation.x = lerp(head.rotation.x,recoil_damping, 5 * delta)
	#else:
	#	recoil_damping += head.rotation.x
	#print(recoil_duration)
	
func firing():
	current_ammo -= 1
	weapons[weapon_index].animation.seek(0,true)
	weapons[weapon_index].animation.play("Firing")
	weapons[weapon_index].fire.play()
	can_fire = false
	recoil_duration = 0.1
	index = index + 1
	if gunline.is_colliding():
		var target = gunline.get_collider()
		if target.is_in_group("Enemy"):
			hitmarker.play("HitMarker")
			hitmarker_sound.play()
			target.health -= damage
	yield(get_tree().create_timer(rate_of_fire), "timeout")
	can_fire = true
	
func reload(reload_speed,reload_sound,reload_animation):
		reload_sound.play()
		reload_animation.play("Reloading")
		yield(get_tree().create_timer(reload_speed), "timeout")
		difference = max_mag_ammo - current_ammo
		if difference > max_ammo:
			current_ammo += max_ammo
			max_ammo -= max_ammo
		else:
			current_ammo = max_mag_ammo
			max_ammo = max_ammo - difference
			
