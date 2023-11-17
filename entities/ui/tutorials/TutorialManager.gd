extends Control

class_name TutorialManager

@export var tutorial_dialog : TutorialDialog
@export var basic_control_tutorial : PackedScene
@export var mob_tutorial: PackedScene

var current_tutorial : Container = null

func show_basic_controls() -> void:
	show_tutorial(basic_control_tutorial)

func show_mob_tutorial() -> void:
	show_tutorial(mob_tutorial)
	
func show_tutorial(scene: PackedScene) -> void:
	assert(scene)
	if current_tutorial:
		tutorial_dialog.remove_tutorial(current_tutorial)
		current_tutorial = null
	
	current_tutorial = scene.instantiate() as Container
	tutorial_dialog.add_tutorial(current_tutorial)
	tutorial_dialog.visible = true


func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("ui_accept"):
		for child in get_children():
			child.visible = false
			
	if event.is_action_pressed("blelele"):
		$Mobs.visible = false
