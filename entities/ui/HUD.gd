extends Control

class_name HUD

@export var cheeseboi_label : Label
@export var steps_label : Label

func _ready() -> void:
	assert(cheeseboi_label)
	assert(steps_label)
	
func set_cheesebois(eaten: int, available: int) -> void:
	cheeseboi_label.text = str(eaten) + "/" + str(available)

func set_steps(steps: int) -> void:
	steps_label.text = str(steps)

