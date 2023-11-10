extends AutoTriggeredCommand

class_name MobMoveCommand

var mob: Mob

var from: Vector2i
var direction: Vector2i
var speed: int

func _init(_mob: Mob) -> void:
	assert(_mob)
	mob = _mob
	from = mob.coords


func do(level: Level, snek: Snek) -> void:
	var mobs = level.get_mobs().filter(func(it): it != mob)
	var tiles = mob.movement.get_tiles(level, snek, mob)
	for tile in tiles:
		var theoretical_rect = mob.get_rect()
		theoretical_rect.position = tile
		for other in mobs:
			if theoretical_rect.intersects((other as Mob).get_rect()):
				return
		mob.set_coords(tile)
		if tile in snek.coords:
			return # prevent "quantum tunneling"

	
func undo(level: Level, snek: Snek) -> void:
	assert(from)
	mob.coords = from
	
func debug_string() -> String:
	return "MobMoveCommand"
