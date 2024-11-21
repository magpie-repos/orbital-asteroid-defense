extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true

func _on_cpu_particles_2d_finished() -> void:
	$CPUParticles2D.emitting = false
	queue_free()
