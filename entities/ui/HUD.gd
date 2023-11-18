extends Control

class_name HUD

@export var cheeseboi_label : Label
@export var steps_label : Label
@export var touch_toggle: CheckBox

signal touch_controls_toggled
signal exit_button_pressed

func _ready() -> void:
	assert(cheeseboi_label)
	assert(steps_label)
	
func set_cheesebois(eaten: int, available: int) -> void:
	cheeseboi_label.text = "%02d/%02d" % [eaten, available]

func set_steps(steps: int) -> void:
	steps_label.text = str(steps)
	
func set_touch_controls(value: bool) -> void:
	touch_toggle.set_pressed_no_signal(value)

func _on_check_box_toggled(button_pressed: bool) -> void:
	Settings.touch_controls = button_pressed
	touch_controls_toggled.emit(button_pressed)


func _on_exit_button_pressed() -> void:
	exit_button_pressed.emit()
