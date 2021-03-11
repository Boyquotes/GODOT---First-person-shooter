extends Spatial

onready var animation = $AnimationPlayer
onready var reload_sound = $Reload
onready var fire = $Fire
var weapon_name = "AWP"
var mode = "single"
var reload_speed = 2.5
var ads_speed = 7
var rate_of_fire = 1.1667
var damage = 90
var RecoilPatternY = [8,8,8,8,8,8,8,8]
var RecoilPatternX = [0,0,0,0,0,0,0,0]
var max_ammo = 24
var max_mag_ammo = 8
var current_ammo = max_mag_ammo
var difference = 0
