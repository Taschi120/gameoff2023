extends MobMovement

# Movement behavior which moves an entity along a closed loop of points.
# Points must be connected by a horizontal or vertical line - no diagonals!
class_name StraightLinePolyMovement

@export var points: Array[Vector2i]
@export var wait_times: Array[int]
@export var speed := 1

# wait time before movement first starts
@export var initial_wait_time := 0

enum Mode { INITIAL_WAIT, MOVE, WAIT }

var current_mode := Mode.INITIAL_WAIT
var next_point : Vector2i
var wait_time_counter := 0

func get_tiles(level: Level, snek: Snek, mob: Mob) -> Array[Vector2i]:
	assert(points)
	assert(points.size() >= 2)
	assert(wait_times)
	assert(wait_times.size() == points.size())
	assert(speed >= 1)
	
	var current_pos = mob.coords

	if current_mode == Mode.INITIAL_WAIT:
		if wait_time_counter >= initial_wait_time:
			current_mode = Mode.MOVE
			assert(current_pos == points[0])
			next_point = points[1]
		else:
			wait_time_counter += 1
			
	elif current_mode == Mode.WAIT:
		var next_point_idx = points.find(next_point)
		if wait_time_counter >= wait_times[next_point_idx]:
			current_mode = Mode.MOVE
			assert(current_pos == points[next_point_idx])
			if next_point_idx < points.size() - 1:
				next_point = points[next_point_idx + 1]
			else:
				next_point = points[0]
		else:
			wait_time_counter += 1
			
	if current_mode == Mode.MOVE:
		var vector = next_point - current_pos
		var distance = ShittyVector2i.shitty_length(vector)
		var direction = ShittyVector2i.shitty_normalize(vector)
		var actual_speed = min(distance, speed)
		
		var go_to_tile = current_pos
		var result: Array[Vector2i] = []
		for i in range(0, actual_speed):
			go_to_tile += direction
			if go_to_tile in snek.coords:
				break
			result.append(go_to_tile)
		
		if not result.is_empty() and result[-1] == next_point:
			current_mode = Mode.WAIT
			wait_time_counter = 0
		
		return result
	
	
	return []


