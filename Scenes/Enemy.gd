extends KinematicBody

var health = 120 # 200
signal dead
onready var collider = $Collision
onready var healthbar = $HealthBar/Viewport/Health
func _ready():
	pass
func _process(delta):
	healthbar.value = health
	if health <= 0:
		visible = false
		collider.disabled = true
		health = 120
		yield(get_tree().create_timer(3), "timeout")
		visible = true
		collider.disabled = false
