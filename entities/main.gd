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
	snek.trapped.connect(func(): show_game_over_prompt(Globals.GameOverCause.STUCK))
	snek.died.connect(func(): show_game_over_prompt(Globals.GameOverCause.DEAD))
	command_executor.level = $Level
	command_executor.snek = $Level/Snek
	snek.command_executor = command_executor
	level._show_tutorials()

func update_hud() -> void:
	var level = get_level()
	var snek = get_snek()
	hud.set_cheesebois(level.cheesebois_eaten, level.starting_cheeseboi_count)
	hud.set_steps(level.step_count)

func show_game_over_prompt(cause: Globals.GameOverCause) -> void:
	$StuckPrompt.open(cause)
	
func show_end_of_level_dialog() -> void:
	var callback = func(result):
		handle_end_of_level_choice(result)
	var level = get_level()
	level_score_dialog.open( \
		level.get_level_name(), \
		level.cheesebois_eaten, \
		level.step_count, \
		level.get_score(), \
		callback)
		
func handle_end_of_level_choice(result: LevelScoreDialog.Result) -> void:
	if result == LevelScoreDialog.Result.NEXT_LEVEL:
		LevelManager.load_next_level($Level.level_id, get_tree(), $Level)
	else:
		assert(result == LevelScoreDialog.Result.MAIN_MENU)
		get_tree().change_scene_to_file("res://entities/LevelSelect.tscn")
		
func load_level(data: Dictionary) -> void:
	var scene_resource = load("res://entities/levels/%s.tscn" % data["id"])
	var level = scene_resource.instantiate() as Level
	assert(level)
	remove_child($Level)
	level.name = "Level"
	level.level_name = data["display_name"]
	level.level_id = data["id"]
	add_child(level)
	move_child(level, 0)
	
func get_level() -> Level:
	return $Level as Level
	
func get_snek() -> Snek:
	return $Level/Snek as Snek
