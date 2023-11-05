extends PanelContainer

class_name LevelScoreDialog

@export var header_label: Label
@export var cheeseboi_label: Label
@export var turns_label: Label
@export var score_label: Label

enum Result { NEXT_LEVEL, MAIN_MENU }
var callback = null

func open(level_name: String, \
		cheesebois: int, turns: int, score: int, \
		_callback) -> void:
	
	assert(header_label)
	assert(cheeseboi_label)
	assert(turns_label)
	assert(score_label)
	
	assert(_callback)
	assert(callback == null)
	callback = _callback
	
	header_label.text = "Level %s cleared!" % level_name
	cheeseboi_label.text = str(cheesebois)
	turns_label.text = str(turns)
	score_label.text = str(score)
	
	visible = true

func _on_next_level_button_pressed() -> void:
	visible = false
	callback.call(Result.NEXT_LEVEL)

func _on_level_select_button_pressed() -> void:
	visible = false
	callback.call(Result.MAIN_MENU)
