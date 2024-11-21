extends Node2D

var rot_speed: float = 50

var missile_scene: PackedScene = preload("res://scenes/missile.tscn")
var missile_limit: int = 10
var curr_missiles: int = 0

func _process(delta: float) -> void:
	
	##Handle Input
	if Input.is_anything_pressed():
		## Handle gun rotation
		if Input.is_action_pressed("gun_count_clock"):
			rotation += rot_speed * (PI / 180) * delta * -1
		if Input.is_action_pressed("gun_clock"):
			rotation += rot_speed * (PI / 180) * delta
		
		##Missile spawning
		if Input.is_action_just_pressed("shoot") && curr_missiles < missile_limit:
			
			spawn_missile(Vector2.ZERO, Vector2.from_angle(rotation))

func spawn_missile(missile_pos: Vector2, missile_vector: Vector2):
	var new_missile: Missile = missile_scene.instantiate()
	new_missile.position = missile_pos
	new_missile.vector = missile_vector
	get_parent().add_child(new_missile)
	curr_missiles += 1
	new_missile.connect("exploded", _on_missile_exploded)
	
func _on_missile_exploded(exploded_missile: Missile) -> void:
	##TODO disconnect and destroy missile properly
	exploded_missile.queue_free()
	curr_missiles -= 1
