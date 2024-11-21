extends Node2D

var rot_speed: float = 50
var missile_scene: PackedScene = preload("res://scenes/missile.tscn")
var stored_missiles: int = 5
var missile_cap: int = 5

func _process(delta: float) -> void:
	
	##Handle Input
	if Input.is_anything_pressed():
		## Handle gun rotation
		if Input.is_action_pressed("gun_count_clock"):
			rotation += rot_speed * (PI / 180) * delta * -1
		if Input.is_action_pressed("gun_clock"):
			rotation += rot_speed * (PI / 180) * delta
		
		##Missile spawning
		if Input.is_action_just_pressed("shoot") && stored_missiles >= 1:
			stored_missiles -= 1
			spawn_missile(Vector2.ZERO, Vector2.from_angle(rotation))

func spawn_missile(missile_pos: Vector2, missile_vector: Vector2):
	var new_missile: Missile = missile_scene.instantiate()
	new_missile.position = missile_pos
	new_missile.vector = missile_vector
	get_parent().add_child(new_missile)
	new_missile.connect("exploded", _on_missile_exploded)
	
	$MissileRechargeTimer.start()
	
func _on_missile_exploded(exploded_missile: Missile) -> void:
	exploded_missile.disconnect("exploded", _on_missile_exploded)

func _on_missile_recharge_timer_timeout() -> void:
	if stored_missiles < missile_cap:
		stored_missiles += 1
		$MissileRechargeTimer.start()
