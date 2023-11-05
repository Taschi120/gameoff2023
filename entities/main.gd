extends Node

@onready var hud = $HUD as HUD
@onready var command_executor = $CommandExecutor as CommandExecutor
@onready var level_score_dialog = $LevelScoreDialog as LevelScoreDialog

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(hud)
	var snek = $PrototypeLevel/Snek as Snek
	var level = get_level()
	level.eaten.connect(update_hud)
	level.moved.connect(update_hud)
	level.exited.connect(show_end_of_level_dialog)
	snek.trapped.connect(show_stuck_prompt)
	command_executor.level = $PrototypeLevel
	command_executor.snek = $PrototypeLevel/Snek
	snek.command_executor = command_executor

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
	
func get_level() -> Level:
	return $PrototypeLevel as Level
	
func get_snek() -> Snek:
	return $PrototypeLevel/Snek as Snek
