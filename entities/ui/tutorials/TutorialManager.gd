extends Control

class_name TutorialManager

func show_basic_controls() -> void:
	$BasicControls.visible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		for child in get_children():
			child.visible = false
