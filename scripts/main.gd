extends Node2D
var score: int = 0
var game_over: bool = false
var diff_mod: float = 1

@onready var player_scene: PackedScene = preload("res://scenes/player.tscn")
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
@onready var planet_scene: PackedScene = preload("res://scenes/planet.tscn")
@onready var game_over_ui = $GameOverUI
@onready var gun: Node2D = $Gun
@onready var a_spawner: Node2D = $AsteroidSpawner
@onready var solar_system: Node2D = $SolarSystem


func _ready() -> void:
	new_game()

func _process(delta: float) -> void:
	if  Input.is_anything_pressed():
		if Input.is_action_just_pressed("reset"):
			new_game()

	a_spawner.difficulty = score * diff_mod

func score_points(point_value: int) -> void:
	score += point_value

func new_game() -> void:
	score = 0
	game_over = false
	game_over_ui.hide()
	
	get_tree().paused = false
	gun.show()
	solar_system.show()
	
	var player: Node2D = player_scene.instantiate()
	player.connect("died", _on_player_died)
	add_child(player)

func end_game() -> void:
	get_tree().paused = true
	gun.hide()
	solar_system.hide()
	
	##Blow up asteroids
	for node in get_tree().get_nodes_in_group("asteroid"):
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
