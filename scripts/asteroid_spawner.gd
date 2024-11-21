extends Node

@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")
var game_over: bool = false
var safe_margin: float = 1.05
@onready var window_size: float = get_viewport().size.x

func _ready() -> void:
	$AsteroidSpawnTimer.timeout.emit()

func _on_asteroid_spawn_timer_timeout() -> void:
	if game_over == false:
		spawn_asteroid()
	
	$AsteroidSpawnTimer.start()

func spawn_asteroid() -> void:
	var asteroid: Asteroid = asteroid_scene.instantiate()
	var spawn_vector: Vector2 = Vector2.from_angle(randf_range(0, 2 * PI))
	asteroid.position = spawn_vector * sqrt(2) * window_size / 2 * safe_margin
	asteroid.rot_speed *= randf_range(1, 1.2) * [-1, 1].pick_random()
	add_child(asteroid)
