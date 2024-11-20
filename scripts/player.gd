extends Node2D

var player_rot_speed: float = 15


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	rotate((PI / 180) * player_rot_speed * delta)
