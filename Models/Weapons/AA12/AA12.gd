extends Spatial

var weapon_name = "AA12"
var mode = "single"
onready var animation = $AnimationPlayer
onready var reload_sound = $Reload
onready var fire = $Fire
var reload_speed = 1.8
var ads_speed = 9
var rate_of_fire = 0.25
var damage = 38
var RecoilPatternY = [20,20,20,20,20,20,20,20]
var RecoilPatternX = [80,150,80,-80,-150,-80,80,150]
var max_ammo = 50
var max_mag_ammo = 10
var current_ammo = max_mag_ammo
var difference = 0
