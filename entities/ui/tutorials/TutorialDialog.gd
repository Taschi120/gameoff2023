extends CenterContainer

class_name TutorialDialog

@export var target_container: Container

func _ready():
	assert(target_container)

func _on_exit_button_pressed() -> void:
	visible = false

func add_tutorial(tutorial: Container) -> void:
	target_container.add_child(tutorial)
	target_container.move_child(tutorial, 0)
	
func remove_tutorial(tutorial: Container) -> void:
	target_container.remove_child(tutorial)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		visible = false
