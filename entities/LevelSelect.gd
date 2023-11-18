extends Node

class_name LevelSelect

@export var level_button_container : Container

func _ready() -> void:
	for level in LevelManager.LEVELS:
		var button = Button.new()
		button.text = level["display_name"]
		button.pressed.connect(func(): _on_level_button_pressed(level))
		level_button_container.add_child(button)

func _on_level_button_pressed(level: Dictionary) -> void:
	print("Level chosen: %s [%s]" % [level["display_name"], level["id"]])
	LevelManager.load_level(level, get_tree(), self)


func _on_info_button_pressed() -> void:
	$MainMenu.visible = true


func _on_main_menu_closed() -> void:
	$MainMenu.visible = false
