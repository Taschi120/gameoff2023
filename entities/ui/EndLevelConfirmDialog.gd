extends CenterContainer

class_name EndLevelConfirmDialog

@export var exit_button: Button
@export var continue_button: Button

enum Result { CONTINUE, END_LEVEL }

signal result

func _ready() -> void:
	assert(exit_button)
	assert(continue_button)

func open() -> void:
	visible = true

func _on_exit_pressed() -> void:
	visible = false
	result.emit(Result.END_LEVEL)

func _on_continue_pressed() -> void:
	visible = false
	result.emit(Result.CONTINUE)
