extends Level

func get_level_name() -> String:
	return "Prototype"

func _show_tutorials() -> void:
	tutorial_manager.show_basic_controls()
