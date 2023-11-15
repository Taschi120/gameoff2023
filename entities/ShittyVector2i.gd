extends Node

func shitty_normalize(v: Vector2i) -> Vector2i:
	if v.x == 0:
		if v.y <= -1:
			return Globals.UP
		elif v.y >= 1:
			return Globals.DOWN
			
	elif v.y == 0:
		if v.x <= -1:
			return Globals.LEFT
		elif v.x >= 1:
			return Globals.RIGHT
			
	assert(false, "Can't shitty_normalize Vector %" % v)
	return Globals.DOWN


func shitty_length(v: Vector2i) -> int:
	if v.x == 0:
		return abs(v.y)
	elif v.y == 0:
		return abs(v.x)
		
	assert(false, "Can't calculate shitty_length  for Vector %" % v)
	return 0
