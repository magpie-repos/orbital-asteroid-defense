extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true
	var audio_manager: AudioManager = get_parent().find_child("AudioManager")
	audio_manager.play_sound("explosion")

func _on_cpu_particles_2d_finished() -> void:
	$CPUParticles2D.emitting = false
	queue_free()
