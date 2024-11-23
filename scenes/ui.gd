extends Control

##Missile Icon Display
@onready var missile_icon_scene: PackedScene = preload("res://scenes/missile_ui_icon.tscn")
@onready var missile_display: Node2D = $MissileIconDisplay
var icon_rotation_offset: float = 0
var missile_count: int = 0

func update_missile_count_display(missile_count: int) -> void:
	var missile_icon_spacing: float
	var missile_icon_distance: float = 35
	var missile_icon_array: Array [Node2D] = []
	
	if missile_count > 0:
		missile_icon_spacing = 2 * PI / missile_count 
	else:
		missile_icon_spacing = 0
	
	if missile_icon_array.size() < missile_count:
		var new_icon: Node2D = missile_icon_scene.instantiate()
		missile_display.add_child(new_icon)
		missile_icon_array.append(new_icon)
	
	if missile_icon_array.size() > missile_count:
		missile_icon_array[missile_icon_array.size() - 1].queue_free()
		missile_icon_array.remove_at(missile_icon_array.size() - 1)

	##Update icon positioning
	for i in range(missile_icon_array.size()):
		##Space icons effectively around player
		var vector = Vector2.ZERO + Vector2.UP.from_angle(missile_icon_spacing * i)
		vector = vector.rotated(deg_to_rad(icon_rotation_offset))
		missile_icon_array[i].position = (vector * missile_icon_distance)	
