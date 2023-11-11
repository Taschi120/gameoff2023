extends Command

class_name WaitCommand

func can_do(_level, snek: Snek) -> bool:
	return not snek.paused
	
func do(level: Level, snek: Snek) -> void:
	assert(can_do(level, snek))
	level.step_count += 1
	snek.moved.emit()

func undo(level: Level, snek: Snek) -> void:
	level.step_count -= 1
	snek.moved.emit()

func debug_string() -> String:
	return "WaitCommand"
