extends CenterContainer

class_name LevelSelectionConfirmationDialog

signal cancelled
signal confirmed

func _on_yes_button_pressed() -> void:
	visible = false
	confirmed.emit()

func _on_no_button_pressed() -> void:
	visible = false
	cancelled.emit()
