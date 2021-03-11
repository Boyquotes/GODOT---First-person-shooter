extends KinematicBody

var mouse_sensitivity = 0.1
var walk_speed = 8
var sprint_multiplier = 1.5
var crouch_multiplier = 0.5

var ground_acceleration = 8
var air_acceleration = 5
var acceleration = ground_acceleration

var jump_height = 10 # 8
var gravity = 25 # 9.8

var stick_amount = 10

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()
var grounded = true
var sprint_speed = 1
var crouch_speed = 1

onready var camera = $Head/Camera

#InGameVariables#
var menu = false
var Health = 120
var current_health = 120
var regen_time = 0
var weapon_type = "rifle"
var regen = false
var sprinting = false
var sprinting_cooldown = true
var stamina_time = 5
var fall = 0


var max_ammo = 200
var max_mag_ammo = 30
var current_ammo = 30
var difference = 0
var can_fire = true
onready var gunline = $Head/Camera/GunLine
var damage = 30

var RecoilPatternY = [150,150,150,150,150,150,150,150]
var RecoilPatternX = [80,150,80,-80,-150,-80,80,150]
var index = 0

onready var fallDamage_Player = $GameHUD/PlayerBoard/CenterContainer/FallDamage720P/AnimationPlayer
onready var ak47_animation = $Head/Hand/AK47/AnimationPlayer
onready var hitmarker = $GameHUD/HitMarker/HitMarkerPlayer
onready var HealthLabel = $GameHUD/PlayerBoard/HealthAndStamina/HealthLabel
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		menu = !menu
	print(gravity_vec.length())
	get_node("GameHUD/PlayerBoard/HealthAndStamina/HP Bar instant").value = current_health
	get_node("GameHUD/PlayerBoard/HealthAndStamina/StaminaBar").value = stamina_time
	#get_node("GameHUD/PlayerBoard/AmmoLabel").set_text(str(current_ammo) + " / " + str(int(max_ammo)))
	HealthLabel.set_text(str(int(current_health)) + " / " + str(120))
	Health = clamp(Health,0, 120)
	current_health = clamp(current_health,0, 120)
	#print(len(RecoilPatternY) - 1)

	#print(index)
func _input(event):
	if event is InputEventMouseMotion and menu == false:
		rotation_degrees.y  -= event.relative.x * mouse_sensitivity
		$Head.rotation_degrees.x = clamp($Head.rotation_degrees.x - event.relative.y * mouse_sensitivity, -90,90)
	
	direction = Vector3()
	if Input.is_action_pressed("w") and menu == false:
		direction -= transform.basis.z
	elif Input.is_action_pressed("s") and menu == false:
		direction += transform.basis.z
	if Input.is_action_pressed("a") and menu == false:
		direction -= transform.basis.x
	elif Input.is_action_pressed("d") and menu == false:
		direction += transform.basis.x
		
	direction = direction.normalized()
	if Input.is_action_pressed("sprint") and sprinting_cooldown and is_on_floor() and !Input.is_action_pressed("Aiming") and menu == false and Input.is_action_pressed("a") or Input.is_action_pressed("sprint") and sprinting_cooldown and is_on_floor() and !Input.is_action_pressed("Aiming") and menu == false and Input.is_action_pressed("w") or Input.is_action_pressed("sprint") and sprinting_cooldown and is_on_floor() and !Input.is_action_pressed("Aiming") and menu == false and Input.is_action_pressed("s") or Input.is_action_pressed("sprint") and sprinting_cooldown and is_on_floor() and !Input.is_action_pressed("Aiming") and menu == false and Input.is_action_pressed("d"):
		sprint_speed = sprint_multiplier
		sprinting = true
	elif Input.is_action_pressed("Aiming"):
		sprint_speed = 0.7
		mouse_sensitivity = 0.05
		sprinting = false
	else:
		mouse_sensitivity = 0.1
		sprint_speed = 1
		sprinting = false
	if Input.is_action_pressed("Crouch"):
		crouch_speed = crouch_multiplier
		sprint_speed = 1 # The control key cancel the shift key if it is pressed
	else:
		crouch_speed = 1
	
func _physics_process(delta):
	if Input.is_action_pressed("Aiming"):
		camera.fov = lerp(camera.fov, 70, 5 * delta)
	else:
		camera.fov = lerp(camera.fov, 100, 5 * delta)
	
	if current_health < 120:
		if regen == false:
			regen_time += 1 * delta
			if regen_time >= 3:
				regen = true
				regen_time = 0
	elif current_health == 120:
		regen = false
	if regen == true:
		current_health += 30 * delta
	#Sprint Mechanic
	
	if sprinting and stamina_time >= 0:
		stamina_time -= 1 * delta
		if stamina_time <= 0 or stamina_time == -0:
			sprinting_cooldown = false
				
	if !sprinting and stamina_time <= 5:
		stamina_time += 2.2 * delta
		if stamina_time >= 5 or stamina_time == 5:
			sprinting_cooldown = true
	
	#Fall Detection
	if gravity_vec.length() != 0 and not is_on_floor():
		fall = gravity_vec.length()
	if fall >= 25 and is_on_floor():
		fall_damage()
		fall = 0
	if is_on_floor():
		gravity_vec = -get_floor_normal() * stick_amount # The gravity is in the direction of the ground to climb it more easily
		acceleration = ground_acceleration
		grounded = true
	else:
		if grounded: # Just before leaving the floor we reset the gravity vector to avoid falling in an angle
			gravity_vec = Vector3.ZERO
			grounded = false
		else:
			gravity_vec += Vector3.DOWN * gravity * delta
			acceleration = air_acceleration
	
	if Input.is_action_pressed("jump") and is_on_floor():
		grounded = false
		gravity_vec = Vector3.UP * jump_height
	
	velocity = velocity.linear_interpolate(direction * walk_speed * crouch_speed * sprint_speed, acceleration * delta) # acceleration
	movement.z = velocity.z + gravity_vec.z # The gravity is added
	movement.x = velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	move_and_slide(movement, Vector3.UP)

func fall_damage():
	current_health -= fall * 2.5
	fallDamage_Player.play("TakeDamage")
