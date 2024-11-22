extends Node2D
class_name Asteroid

##Physics Vars
var mass: float = 0.5
var speed: float = 15
var vector: Vector2 = Vector2.ZERO
var value: int = 1
##Refs
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
var game_manager: Node2D

var rot_speed: float = 8

var player_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	vector = position.direction_to(player_pos)
	add_to_group("has_gravity")
	add_to_group("asteroid")

	game_manager = get_tree().get_first_node_in_group("main")

func _process(delta: float) -> void:
	position += vector * speed * delta
	rotation += (PI / 180) * rot_speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	var explosion: Node2D = explosion_scene.instantiate()
	explosion.position = position
	add_sibling(explosion)
	
	game_manager.score_points(value)
	
	queue_free()
