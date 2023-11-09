extends AutoTriggeredCommand

class_name EatCommand

var target: Cheeseboi

func _init(_target: Cheeseboi):
	assert(_target != null)
	target = _target

func do(level: Level, snek: Snek) -> void:
	level.remove_mob(target)
	level.cheesebois_eaten += 1
	level.eaten.emit()
	snek.grow()
	
func undo(level: Level, snek: Snek) -> void:
	level.add_mob(target)
	level.cheesebois_eaten -= 1
	level.eaten.emit()
	snek.prune()
	
func debug_string() -> String:
	return "EatCommand (%d, %d)" % [target.coords.x, target.coords.y] 
