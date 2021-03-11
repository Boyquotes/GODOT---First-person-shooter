extends Spatial

onready var reload_sound = $Reload
onready var animation = $AnimationPlayer
var weapon_name = "Vector"
var mode = "auto"
var reload_speed = 0.4
var ads_speed = 11
var rate_of_fire = 0.1
var damage = 40
var RecoilPatternY = [2,2,5,5,5,6,6,6]
var RecoilPatternX = [0,0,0,0,0,0,0,0]
var max_ammo = 100
var max_mag_ammo = 30
var current_ammo = max_mag_ammo
var difference = 0
