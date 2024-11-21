extends Node2D
class_name Planet

var mass: float = 4
var rot_speed: float = -0.5

##Orbit Vars
@export var orbit_speed: float = 15
@export var orbit_distance: float = 200
var orbit_center: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.UP
var vector_from_origin: Vector2 = Vector2.RIGHT

func _ready() -> void:
	add_to_group("has_gravity")
	mass *= (scale.x + scale.y) / 2
	
	orbit_center = get_parent().position
	position =  orbit_center + (vector_from_origin * orbit_distance)

func _process(delta: float) -> void:
	rotation += rot_speed * delta

func _physics_process(delta: float) -> void:
	##Horrible code to move the planet on an orbit
	var curr_angle: float = vector_from_origin.angle()
	var new_angle: float = curr_angle + (orbit_speed * delta * (PI/180))
	vector_from_origin = Vector2.from_angle(new_angle)
	var new_pos: Vector2 = vector_from_origin * orbit_distance
	velocity = Vector2(position.x - new_pos.x, position.y - new_pos.y)
	position = new_pos
	
