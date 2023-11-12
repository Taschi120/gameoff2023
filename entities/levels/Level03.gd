extends Level

@export var speed = 1
@export var point_a : Vector2
@export var point_b : Vector2
@export var wait_time = 0

enum Mode { WAIT_A, MOVE_A, WAIT_B, MOVE_B }

var current_mode
var wait_timer = 0

func get_tiles(level: Level, snek: Snek, mob: Mob) -> Array[Vector2i]:
	return []
