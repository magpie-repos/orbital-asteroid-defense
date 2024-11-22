extends Node2D
var player_rot_speed: float = 15
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")

signal died

func _process(delta: float) -> void:
	rotate((PI / 180) * player_rot_speed * delta)

func _on_player_area_2d_area_entered(area: Area2D) -> void:
	print
	died.emit()
	var explosion: Node2D = explosion_scene.instantiate()
	explosion.position = position
	add_sibling(explosion)
	queue_free()
	
