extends Node2D

@onready var win_size: Vector2 = get_viewport().size
var rot_speed: float = 60
var missile_scene: PackedScene = preload("res://scenes/missile.tscn")
##Missile count display
var missile_icon_scene: PackedScene = preload("res://scenes/missile_ui_icon.tscn")
@export var missile_display: Node2D
var missile_icon_distance: float = 35
var missile_icon_array: Array [Node2D] = []
var icon_rotation_offset: float = 0
	
var stored_missiles: int = 5
var missile_cap: int = 5

func _ready() -> void:
	update_stored_missile_display(0)

func _process(delta: float) -> void:
	
	update_stored_missile_display(delta)
	icon_rotation_offset += 10 * delta
	
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

func update_stored_missile_display(delta: float) -> void:
	var missile_icon_spacing: float
	if stored_missiles > 0:
		missile_icon_spacing = deg_to_rad(360 / stored_missiles)
	else:
		missile_icon_spacing = 0
	
	if missile_icon_array.size() < stored_missiles:
		var new_icon: Node2D = missile_icon_scene.instantiate()
		missile_display.add_child(new_icon)
		missile_icon_array.append(new_icon)
	
	if missile_icon_array.size() > stored_missiles:
		missile_icon_array[missile_icon_array.size() - 1].queue_free()
		missile_icon_array.remove_at(missile_icon_array.size() - 1)

	##Update icon positioning
	for i in range(missile_icon_array.size()):
		##Space icons effectively around player
		var vector = Vector2.ZERO + Vector2.UP.from_angle(missile_icon_spacing * i)
		vector = vector.rotated(deg_to_rad(icon_rotation_offset))
		missile_icon_array[i].position = (vector * missile_icon_distance)	
