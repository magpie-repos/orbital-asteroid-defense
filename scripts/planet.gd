extends Node2D
class_name Planet

var base_mass: float = 4
var mass: float = 0
var rot_speed: float

##Orbit Vars
var orbit_speed: float = 15
var orbit_distance: float = 200
var orbit_center: Vector2
var vector_from_center: Vector2

func _ready() -> void:
	add_to_group("has_gravity")
	orbit_center = get_viewport().size / 2
	rot_speed = randf_range(0.5, 2) * [-1, 1].pick_random()

func _process(delta: float) -> void:
	rotation += rot_speed * delta

func _physics_process(delta: float) -> void:
	var new_angle: float = vector_from_center.angle() + (deg_to_rad(orbit_speed) * delta)
	vector_from_center = orbit_center.from_angle(new_angle)
	position = orbit_center + (vector_from_center * orbit_distance)

func setup_planet(init_scale: float, dist: float, center, speed: float) -> void:
	scale = Vector2(init_scale, init_scale)
	mass = base_mass * init_scale
	orbit_distance = dist
	orbit_center = center
	vector_from_center = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	orbit_speed = speed * randf_range(0.8, 1.2) * [-1, 1].pick_random()
		
	
	
