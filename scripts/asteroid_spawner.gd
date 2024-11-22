extends Node

var game_over: bool = false
var safe_margin: float = 1.05
var difficulty: float = 0
var timer_start_val: float = 8

@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")
@onready var window_size: float = get_viewport().size.x
@onready var spawn_timer: Timer = $AsteroidSpawnTimer

func _ready() -> void:
	for i in range(0, 3):
		spawn_asteroid()
		
func _process(delta: float) -> void:
	spawn_timer.wait_time = timer_start_val - difficulty / 10

func _on_asteroid_spawn_timer_timeout() -> void:
	if game_over == false:
		spawn_asteroid()
	spawn_timer.start()

func spawn_asteroid() -> void:
	var asteroid: Asteroid = asteroid_scene.instantiate()
	var spawn_vector: Vector2 = Vector2.from_angle(randf_range(0, 2 * PI))
	asteroid.position = spawn_vector * sqrt(2) * window_size / 2 * safe_margin
	asteroid.rot_speed *= randf_range(1, 1.2) * [-1, 1].pick_random()
	add_child(asteroid)
