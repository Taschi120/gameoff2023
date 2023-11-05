extends Node

@onready var hud = $HUD as HUD
@onready var command_executor = $CommandExecutor as CommandExecutor

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(hud)
	get_level().eaten.connect(update_hud)
	get_level().moved.connect(update_hud)
	
	command_executor.level = $PrototypeLevel
	command_executor.snek = $PrototypeLevel/Snek
	$PrototypeLevel/Snek.command_executor = command_executor

func update_hud() -> void:
	var level = get_level()
	var snek = get_snek()
	hud.set_cheesebois(level.cheesebois_eaten, level.starting_cheeseboi_count)
	hud.set_steps(level.step_count)

func get_level() -> Level:
	return $PrototypeLevel as Level
	
func get_snek() -> Snek:
	return get_node("Snek") as Snek
