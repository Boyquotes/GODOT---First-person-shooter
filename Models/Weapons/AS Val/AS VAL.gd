extends Spatial

var weapon_name = "AS Val"
var mode = "auto"
onready var animation = $AnimationPlayer
onready var reload_sound = $Reload
onready var fire = $Fire
var reload_speed = 1.8
var ads_speed = 8.5
var rate_of_fire = 0.1
var damage = 50
var RecoilPatternY = [2,2,3,4,5,6,8,0]
var RecoilPatternX = [-0.5,-0.8,-1,-1.5,-1.8,-2,-2,2]
var max_ammo = 140
var max_mag_ammo = 40
var current_ammo = max_mag_ammo
var difference = 0
