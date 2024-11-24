extends Node2D
var player_rot_speed: float = 15
##Gun Variables
var stored_missiles: int = 0
var missile_cap: int = 5
var gun_rot_speed: float = 48
##Scene Refs
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")
@onready var missile_scene: PackedScene = preload("res://scenes/missile.tscn")
##Refs
@onready var player_sprite: Sprite2D = $PlayerSprite
@onready var gun_sprite: Sprite2D = $GunSprite
@onready var missile_recarge_timer: Timer = $MissileRechargeTimer


signal died

func _ready() -> void:
	##Center thing
	gun_sprite.position.y = gun_sprite.position.y / 2
	position = get_viewport().size / 2

func _process(delta: float) -> void:
	player_sprite.rotate(deg_to_rad(player_rot_speed) * delta)

	##Handle Input
	if Input.is_anything_pressed():
		## Handle gun rotation
		if Input.is_action_pressed("gun_count_clock"):
			gun_sprite.rotation += deg_to_rad(gun_rot_speed) * delta * -1
		if Input.is_action_pressed("gun_clock"):
			gun_sprite.rotation += deg_to_rad(gun_rot_speed) * delta

		##Missile spawning
		if Input.is_action_just_pressed("shoot") && stored_missiles >= 1:
			stored_missiles -= 1
			spawn_missile(position, Vector2.from_angle(gun_sprite.rotation))

func spawn_missile(missile_pos: Vector2, missile_vector: Vector2):
	var new_missile: Missile = missile_scene.instantiate()
	new_missile.position = missile_pos
	new_missile.vector = missile_vector
	get_parent().add_child(new_missile)
	missile_recarge_timer.start()

func _on_missile_recharge_timer_timeout() -> void:
	if stored_missiles < missile_cap:
		stored_missiles += 1
		missile_recarge_timer.start()

func _on_player_area_2d_area_entered(area: Area2D) -> void:
	died.emit()
	var explosion: Node2D = explosion_scene.instantiate()
	explosion.position = position
	add_sibling(explosion)
	queue_free()
	
