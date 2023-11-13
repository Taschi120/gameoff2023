extends Control

class_name HUD

@export var cheeseboi_label : Label
@export var steps_label : Label

signal touch_controls_toggled

func _ready() -> void:
	assert(cheeseboi_label)
	assert(steps_label)
	
func set_cheesebois(eaten: int, available: int) -> void:
	cheeseboi_label.text = "%02d/%02d" % [eaten, available]

func set_steps(steps: int) -> void:
	steps_label.text = str(steps)

func _on_check_box_toggled(button_pressed: bool) -> void:
	touch_controls_toggled.emit(button_pressed)


func _on_touch_controls_toggled() -> void:
	pass # Replace with function body.
