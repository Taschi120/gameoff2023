extends Control

class_name HUD

var end_level_dialog_callback = null

func _ready() -> void:
	for child in get_children():
		child.visible = false

func show_end_level_confirmation(callback) -> void:
	assert(end_level_dialog_callback == null)
	end_level_dialog_callback = callback
	$EndLevelConfirmDialog.open()
	
func _on_end_level_confirm_dialog_result(result: EndLevelConfirmDialog.Result) -> void:
	assert(end_level_dialog_callback)
	var callback = end_level_dialog_callback
	end_level_dialog_callback = null
	callback.call(result)
