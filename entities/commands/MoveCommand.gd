extends Command

class_name MoveCommand

var to: Vector2i

var previous_snake_state: Array[Vector2i]

func _init(_to: Vector2i) -> void:
	assert(_to)
	to = _to


func can_do(level: Level, snek: Snek) -> bool:
	assert((snek.coords[0] - to).length() == 1)
	
	if snek.paused:
		print("Cannot move: paused")
		return false
		
	var tile = level.get_tile_map().get_cell_tile_data(0, to)
	if tile and tile.get_custom_data("walkable"):
		var idx = snek.coords.find(to)
		if idx >= 0 and idx != snek.coords.size() - 1:
			print("Cannot move: Tile not walkable")
			return false
		else:
			return not is_blocked_by_mob(level)
	else:
		return false
		
func is_blocked_by_mob(level: Level) -> bool:
	for mob in level.get_mobs():
		if mob.contains_point(to):
			if not mob.snek_can_enter():
				print("cannot move: blocked by mob %s" % mob.name) 
				return true
				
	return false
	

func do(level: Level, snek: Snek) -> void:
	assert(can_do(level, snek))
	previous_snake_state = snek.coords.duplicate(true)
	snek.coords.push_front(to)
	snek.prune()
		
	level.step_count += 1
	snek.moved.emit()
	snek.update_sprites()
	check_trapped(level, snek)

func undo(level: Level, snek: Snek) -> void:
	snek.coords = previous_snake_state.duplicate(true)
	level.step_count -= 1
	snek.moved.emit()
	snek.update_sprites()
	
func check_trapped(level: Level, snek: Snek) -> void:
	var stuck = true
	var snek_length = snek.coords.size()
	for direction in [Globals.UP, Globals.DOWN, Globals.LEFT, Globals.RIGHT]:
		var cell = snek.coords[0] + direction
		if level.can_move_to(cell):
			var idx = snek.coords.find(cell)
			if idx < 0 or idx >= snek_length - 1:
				stuck = false
				break
	if stuck:
		print("trapped")
		snek.trapped.emit()

func debug_string() -> String:
	return "MoveCommand(%d, %d)" % [to.x, to.y]
