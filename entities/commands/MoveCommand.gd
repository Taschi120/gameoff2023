extends Command

class_name MoveCommand

var to: Vector2i

var previous_snake_state: Array[Vector2i]
var cheeseboi: bool

func _init(_to: Vector2i) -> void:
	assert(_to)
	to = _to


func can_do(level: Level, snek: Snek) -> bool:
	assert((snek.coords[0] - to).length() == 1)
	var tile = level.get_tile_map().get_cell_tile_data(0, to)
	if tile and tile.get_custom_data("walkable"):
		var idx = snek.coords.find(to)
		if idx >= 0 and idx != snek.coords.size() - 1:
			return false
		else:
			return true
	else:
		return false

func do(level: Level, snek: Snek) -> void:
	assert(can_do(level, snek))
	previous_snake_state = snek.coords.duplicate(true)
	cheeseboi = level.is_cheeseboi(to)
	snek.coords.push_front(to)
	if cheeseboi:
		level.remove_cheeseboi(to)
		level.cheesebois_eaten += 1
		level.eaten.emit()
	else:
		# prune snek tail
		snek.coords.remove_at(snek.coords.size() - 1)
		
	level.step_count += 1
	snek.moved.emit()
	snek.update_sprites()
	check_trapped(level, snek)
	check_victory(level, snek)
	

func undo(level: Level, snek: Snek) -> void:
	snek.coords = previous_snake_state.duplicate(true)
	if cheeseboi:
		level.add_cheeseboi(to)
		level.cheesebois_eaten -= 1
		level.eaten.emit()
		
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
		
func check_victory(level: Level, snek: Snek) -> void:
	if level.cheesebois_eaten <= 0:
		return # TODO Message?
	if level.is_exit(to):
		print("At level exit!")
		level.exited.emit()
		
	
	
func debug_string() -> String:
	return "MoveCommand(%d, %d)" % [to.x, to.y]
