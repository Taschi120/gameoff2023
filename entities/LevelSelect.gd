extends CenterContainer

class_name LevelSelect

func _on_tutorial_1_pressed() -> void:
	load_level("PrototypeLevel")

func load_level(name: String) -> void:
	var main_screen_resource = load("res://entities/main.tscn")
	var main_screen = main_screen_resource.instantiate() as MainScene

	main_screen.load_level(name)

	get_tree().root.add_child(main_screen)

	get_tree().root.remove_child(self)
	self.queue_free()
