extends CenterContainer

signal closed

func _on_exit_button_pressed() -> void:
	visible = false
	closed.emit()
