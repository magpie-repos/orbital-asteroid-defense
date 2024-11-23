extends Node2D
var score: int = 0
var game_over: bool = false

@onready var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
@onready var asteroid_scene: PackedScene = preload("res://scenes/asteroid.tscn")
@onready var game_over_ui: Control = $GameOverUI
@onready var ui: Control = $UI
@onready var asteroid_spawn_timer: Timer = $AsteroidSpawnTimer

@onready var window_size: Vector2 = get_viewport().size
var asteroid_spawn_margin: float = 15

var player: Node2D

func _ready() -> void:
	new_game()

func _process(delta: float) -> void:
	if  Input.is_anything_pressed():
		if Input.is_action_just_pressed("reset"):
			new_game()

	##Update UI
	if player:
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


func score_points(point_value: int) -> void:
	score += point_value

func new_game() -> void:
	score = 0
	game_over = false
	get_tree().paused = false
	game_over_ui.hide()
	spawn_asteroid()
	asteroid_spawn_timer.start()
	

	player = player_scene.instantiate()
	player.position = window_size / 2
	player.connect("died", _on_player_died)
	add_child(player)
#
func end_game() -> void:
	get_tree().paused = true
	
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

	game_over_ui.show()
	game_over_ui.set_final_score(score)

func _on_player_died() -> void:
	end_game()

func _on_asteroid_spawn_timer_timeout() -> void:
	if game_over == false:
		spawn_asteroid()
		asteroid_spawn_timer.start()
