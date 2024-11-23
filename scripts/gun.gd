extends Node2D

##Missile count display
var missile_icon_scene: PackedScene = preload("res://scenes/missile_ui_icon.tscn")
@export var missile_display: Node2D
var missile_icon_distance: float = 35
var missile_icon_array: Array [Node2D] = []
var icon_rotation_offset: float = 0
	

func _ready() -> void:
	update_stored_missile_display(0)

func _process(delta: float) -> void:
	
	update_stored_missile_display(delta)
	icon_rotation_offset += 10 * delta

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
