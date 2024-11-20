extends Node2D
class_name Missile

var vector: Vector2 = Vector2.UP
var speed: float = 50
@onready var sprite: Sprite2D = $MissileSprite
@onready var window_size: Vector2 = get_viewport().size

signal exploded

func _ready() -> void:
	print("I Live!")

func _process(delta: float) -> void:
	position += vector * speed * delta
	sprite.rotation = get_angle_to(Vector2.UP)
	
	##Check to see if still visible in window; explode if not
	if abs(position.x) > window_size.x / 2 + 15:
		exploded.emit(self)
	if abs(position.y) > window_size.y / 2 + 15:
		exploded.emit(self)
		
func _on_missile_area_2d_area_entered(area: Area2D) -> void:
	print("Boom!")
	exploded.emit(self)
	
