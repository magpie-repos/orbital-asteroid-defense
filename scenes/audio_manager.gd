extends Node2D
class_name AudioManager

##Refs
@onready var missile_sfx: AudioStreamPlayer2D = $MissileSFX
@onready var explosion_sfx: AudioStreamPlayer2D = $ExplosionSFX


func play_sound(tag: String):
	if tag == "missile":
		missile_sfx.play()
	if tag == "explosion":
		explosion_sfx.play()
	
		
