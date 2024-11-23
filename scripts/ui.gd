extends Control
class_name UI

##Missile Icon Display
@onready var missile_icon_scene: PackedScene = preload("res://scenes/missile_ui_icon.tscn")
@onready var missile_display: Node2D = $MissileIconDisplay
var icon_rotation_offset: float = 0
var missile_count: int = 0
var missile_icon_array: Array [Node2D] = []
var difficulty_setting: int

@onready var game_over_ui: Control = $GameOverUI
@onready var game_over_score_label: Label = $GameOverUI/CenterContainer/VBoxContainer/FinalScore
@onready var missile_icons: Node2D = $MissileIconDisplay
@onready var pause_ui: Control = $PauseUI

var paused: bool = false
var pause_timeout: bool = false

func _process(delta: float) -> void:
	icon_rotation_offset += deg_to_rad(5)

	if Input.is_action_just_pressed("pause"):
		if paused == false:
			pause_game()
		else:
			resume_game()

func pause_game() -> void:
	get_tree().paused = true
	pause_timeout = true
	$PauseTimer.start()
	paused = true
	pause_ui.show()

func resume_game() -> void:
	get_tree().paused = false
	pause_timeout = true
	$PauseTimer.start()
	paused = false
	pause_ui.hide()

func update_missile_count_display(missile_count: int) -> void:
	var missile_icon_spacing: float
	var missile_icon_distance: float = 35
	
	if missile_count > 0:
		missile_icon_spacing = deg_to_rad(360 / missile_count)
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
		var vector = Vector2.UP.from_angle(missile_icon_spacing * i)
		vector = vector.rotated(deg_to_rad(icon_rotation_offset))
		missile_icon_array[i].position = (vector * missile_icon_distance)	

func show_game_over_text(score: float) -> void:
	game_over_score_label.text = str(score)
	game_over_ui.show()
	missile_icons.hide()

func hide_game_over_text() -> void:
	game_over_ui.hide()
	missile_icons.show()


func _on_pause_timer_timeout() -> void:
	pause_timeout = false
