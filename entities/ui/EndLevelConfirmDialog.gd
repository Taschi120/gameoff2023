extends CenterContainer

class_name EndLevelConfirmDialog

@export var exit_button: Button
@export var continue_button: Button

enum Result { CONTINUE, END_LEVEL }

signal result

var end_level_dialog_callback = null

func _ready() -> void:
	assert(exit_button)
	assert(continue_button)
	assert(end_level_dialog_callback == null)

func show_end_level_confirmation(callback) -> void:
	assert(end_level_dialog_callback == null)
	end_level_dialog_callback = callback
	visible = true
	
func _on_end_level_confirm_dialog_result(result: EndLevelConfirmDialog.Result) -> void:
	assert(end_level_dialog_callback)
	var callback = end_level_dialog_callback
	end_level_dialog_callback = null
	callback.call(result)

func _on_exit_pressed() -> void:
	visible = false
	_on_end_level_confirm_dialog_result(Result.END_LEVEL)

func _on_continue_pressed() -> void:
	visible = false
	_on_end_level_confirm_dialog_result(Result.CONTINUE)
