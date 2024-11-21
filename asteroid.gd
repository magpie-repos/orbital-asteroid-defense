extends Node2D

#Physics Vars
var mass: float = 0.5
var speed: float = 15
var vector: Vector2 = Vector2.ZERO

var rot_speed: float = 8

var player_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	vector = position.direction_to(player_pos)
	add_to_group("has_gravity")

func _process(delta: float) -> void:
	position += vector * speed * delta
	rotation += (PI / 180) * rot_speed * delta
