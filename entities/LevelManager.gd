extends Node

const LEVELS = [
	{
		"id": "Tutorial01",
		"display_name": "Tutorial 1"
	},
	{
		"id": "Tutorial02",
		"display_name": "Tutorial 2"
	}
]

func _ready() -> void:
	for level in LEVELS:
		assert(level["id"])
		assert(level["display_name"])

func load_level(data: Dictionary, tree: SceneTree, prev_scene: Node) -> void:
	var main_screen_resource = load("res://entities/main.tscn")
	var main_screen = main_screen_resource.instantiate() as MainScene

	main_screen.load_level(data)

	get_tree().root.add_child(main_screen)

	get_tree().root.remove_child(prev_scene)
	prev_scene.queue_free()
