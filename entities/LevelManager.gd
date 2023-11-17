extends Node

const LEVELS = [
	{
		"id": "Level01",
		"display_name": "1"
	},
	{
		"id": "Level02",
		"display_name": "2"
	},
	{
		"id": "Level03",
		"display_name": "3"
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
	
func load_next_level(current_level_id: String, tree: SceneTree, prev_scene: Node) -> void:
	var level_data
	for i in range(LEVELS.size() - 1):
		if LEVELS[i]["id"] == current_level_id:
			level_data = LEVELS[i + 1]
			
	if level_data:
		load_level(level_data, tree, prev_scene)
	else:
		assert(current_level_id == LEVELS[-1]["id"])
		tree.change_scene_to_file("res://entities/ui/EndScreen.tscn")
