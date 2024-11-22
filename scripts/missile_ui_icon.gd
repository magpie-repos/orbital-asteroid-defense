extends Node2D

var spin_speed: float = 1

func _ready() -> void:
	spin_speed *= randf_range(0.8, 1.2) * [-1, 1].pick_random()

func _process(delta: float) -> void:
	rotation += deg_to_rad(spin_speed)
