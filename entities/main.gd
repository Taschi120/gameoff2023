extends Node

class_name MainScene

@onready var hud = $HUD as HUD
@onready var command_executor = $CommandExecutor as CommandExecutor
@onready var level_score_dialog = $LevelScoreDialog as LevelScoreDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(hud)
	var snek = $Level/Snek as Snek
	var level = get_level()
	level.eaten.connect(update_hud)
	level.moved.connect(update_hud)
	level.exited.connect(show_end_of_level_dialog)
	level.tutorial_manager = $TutorialManager
	snek.trapped.connect(show_stuck_prompt)
	command_executor.level = $Level
	command_executor.snek = $Level/Snek
	snek.command_executor = command_executor
	level._show_tutorials()

func update_hud() -> void:
	var level = get_level()
	var snek = get_snek()
	hud.set_cheesebois(level.cheesebois_eaten, level.starting_cheeseboi_count)
	hud.set_steps(level.step_count)

func show_stuck_prompt() -> void:
	$StuckPrompt.show()
	
func show_end_of_level_dialog() -> void:
	get_snek().paused = true
	var callback = func(result):
		print(result)
	var level = get_level()
	level_score_dialog.open( \
		level.get_level_name(), \
		level.cheesebois_eaten, \
		level.step_count, \
		level.get_score(), \
		callback)
		
func load_level(name: String) -> void:
	var scene_resource = load("res://entities/levels/%s.tscn" % name)
	var level = scene_resource.instantiate() as Level
	remove_child($Level)
	level.name = "Level"
	add_child(level)
	move_child(level, 0)
	
func get_level() -> Level:
	return $Level as Level
	
func get_snek() -> Snek:
	return $Level/Snek as Snek
