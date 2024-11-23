extends Node2D
class_name Missile

##Misc
var screen_margin: float = 100
##Phys Vars
var velocity: Vector2 = Vector2.UP
var vector: Vector2 = Vector2.UP
var speed: float = 100
var grav_strength: float = 10^100
##Refs
@onready var sprite: Sprite2D = $MissileSprite
@onready var window_size: Vector2 = get_viewport().size
@onready var explosion_scene: PackedScene = preload("res://scenes/explosion.tscn")

var grav_bodies: Array [Node]

func _ready() -> void:
	velocity = vector * speed
	add_to_group("missile")	

func _process(delta: float) -> void:
	## Handle missile trajectory
	vector = velocity.normalized()
	velocity = calc_grav_influence() * grav_strength + vector * speed
	position += velocity * delta
	#Point the missile in the direction it's moving
	sprite.rotation = get_angle_to(velocity.normalized())
	
	##Check to see if still visible in window; explode if not
	if position.x <= 0 - screen_margin || position.y <= 0 - screen_margin:
		queue_free()
	if position.x >= window_size.x + screen_margin || position.y >= window_size.y + screen_margin:
		queue_free()
		
func _on_missile_area_2d_area_entered(area: Area2D) -> void:
	explode()
	
func explode() -> void:
	var explosion: Node2D = explosion_scene.instantiate()
	explosion.position = position
	add_sibling(explosion)
	queue_free()

func calc_grav_influence() -> Vector2:
	var grav_influence: Vector2;
	var direction_to_body: Vector2;
	var distance: float = 0
	
	grav_bodies = get_tree().get_nodes_in_group("has_gravity")
	for b in grav_bodies:
		distance = position.distance_to(b.position) 
		direction_to_body = position.direction_to(b.position)
		grav_influence += direction_to_body * (b.mass / distance)
	
	return grav_influence

func _on_missile_lifetime_timeout() -> void:
	queue_free()
