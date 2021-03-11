extends Spatial

var weapon_name = "Mac10"
var mode = "auto"
#onready var animation = $AnimationPlayer
onready var reload_sound = $Reload
var reload_speed = 1.8
var ads_speed = 8.5
var rate_of_fire = 0.1
var damage = 50
var RecoilPatternY = [30,30,30,30,30,30,30,30]
var RecoilPatternX = [0,0,0,0,0,0,0,0]
var max_ammo = 85
var max_mag_ammo = 25
var current_ammo = max_mag_ammo
var difference = 0
