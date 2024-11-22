extends Control

@onready var final_score_label: Label = $CenterContainer/VBoxContainer/FinalScore

func _ready() -> void:
	set_final_score(0)

func set_final_score(value: int) -> void:
	final_score_label.text = str(value)
