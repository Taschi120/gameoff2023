extends MobMovement

class_name StraightLineMovement

@export var direction: Vector2i
@export var speed: int

func _ready():
	assert(direction in [Globals.UP, Globals.DOWN, Globals.LEFT, Globals.RIGHT])
	assert(speed >= 1)

func get_tiles(level: Level, snek: Snek, mob: Mob) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var cell = mob.coords
	for i in range(speed):
		cell += direction
		result.append(cell)
		
	return result
	
