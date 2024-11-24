extends Node2D
class_name AudioManager

##Refs
@onready var missile_sfx: AudioStreamPlayer2D = $MissileSFX
@onready var explosion_sfx: AudioStreamPlayer2D = $ExplosionSFX
@onready var loose_sfx: AudioStreamPlayer2D = $LooseSFX

var sound_enabled: bool = true

func play_sound(tag: String):
	if sound_enabled:
		if tag == "missile":
			missile_sfx.play()
		if tag == "explosion":
			explosion_sfx.play()
		if tag == "loose":
			loose_sfx.play()

func _on_ui_sound_toggle(value: bool) -> void:
	sound_enabled = value
