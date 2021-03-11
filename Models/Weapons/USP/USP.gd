extends Spatial

onready var reload_sound = $Reload
var weapon_name = "USP"
var mode = "single"
var reload_speed = 2.5
var ads_speed = 12
var rate_of_fire = 0.1
var damage = 35
var RecoilPatternY = [150,150,150,150,150,150,150,150]
var RecoilPatternX = [80,150,80,-80,-150,-80,80,150]
var max_ammo = 30
var max_mag_ammo = 12
var current_ammo = max_mag_ammo
var difference = 0
