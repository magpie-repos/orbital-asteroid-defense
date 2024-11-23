extends Node2D
var score: int = 0
var difficulty: int = 1
var game_over: bool = false

@onready var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")
@onready var planet_scene: PackedScene = preload("res://scenes/planet.tscn")
@onready var game_over_ui: Control = $GameOverUI
@onready var ui: UI = $UI
@onready var asteroid_spawn_timer: Timer = $AsteroidSpawnTimer

var player: Node2D
@onready var window_size: Vector2 = get_viewport().size
var asteroid_spawn_margin: float = 15

func _ready() -> void:
	new_game()

func _process(delta: float) -> void:
	if  Input.is_anything_pressed():
		if Input.is_action_just_pressed("reset"):
			end_game()
			new_game()
		debug_commands()
	
	if player != null:
		ui.update_missile_count_display(player.stored_missiles)

func spawn_asteroid() -> void:
	var asteroid: Asteroid = asteroid_scene.instantiate()
	##This is the lest elegant way to calc the asteroid spawn position
	var dir_string: String = ["r", "d", "l", "u"].pick_random()
	if dir_string == "r":
		asteroid.position = Vector2(1000 + asteroid_spawn_margin, randf_range(0, 1000))
	elif dir_string == "d":
		asteroid.position = Vector2(randf_range(0, 1000), 1000 + asteroid_spawn_margin)
	if dir_string == "l":
		asteroid.position = Vector2(0 - asteroid_spawn_margin, randf_range(0, 1000))
	if dir_string == "u":
		asteroid.position = Vector2(randf_range(0, 1000), 0 - asteroid_spawn_margin)
	add_child(asteroid)

func spawn_planets() -> void:
	if difficulty >= 0:
		var planet: Planet = planet_scene.instantiate()
		planet.setup_planet(0.25, 100, window_size / 2, 15)
		add_child(planet)
	if difficulty >= 1:
		var planet: Planet = planet_scene.instantiate()
		planet.setup_planet(0.10, 250, window_size / 2, 8)
		add_child(planet)
	if difficulty >= 2:
		var planet: Planet = planet_scene.instantiate()
		planet.setup_planet(0.3, 200, window_size / 2, -20)
		add_child(planet)
		
		
func debug_commands() -> void:
	if Input.is_action_just_pressed("debug_kill"):
		end_game()

func new_game() -> void:
	score = 0
	game_over = false
	spawn_asteroid()
	asteroid_spawn_timer.start()
	
	player = player_scene.instantiate()
	player.position = window_size / 2
	player.connect("died", _on_player_died)
	add_child(player)
	spawn_planets()
	
	ui.hide_game_over_text()

func end_game() -> void:
	
	##Blow up asteroids and planets
	for node in get_tree().get_nodes_in_group("has_gravity"):
		var explosion: Node2D = explosion_scene.instantiate()
		explosion.position = node.position
		add_child(explosion)
		node.queue_free()
	##Blow up missiles
	for node in get_tree().get_nodes_in_group("missile"):
		var explosion: Node2D = explosion_scene.instantiate()
		explosion.position = node.position
		add_child(explosion)
		node.queue_free()
	
	if player != null:
		player.queue_free()
		
	
	ui.show_game_over_text(score)

func score_points(point_value: int) -> void:
	score += point_value


func _on_player_died() -> void:
	end_game()

func _on_asteroid_spawn_timer_timeout() -> void:
	if game_over == false:
		spawn_asteroid()
		asteroid_spawn_timer.start()

func _on_diff_slider_changed(value: float) -> void:
	difficulty = value
	end_game()
	new_game()
