extends AutoTriggeredCommand

class_name WinCommand

func do(level: Level, snek: Snek) -> void:
	if level.cheesebois_eaten <= 0:
		return # TODO Message?
	
	snek.paused = true
	level.exited.emit()
	
func undo(_level: Level, snek: Snek) -> void:
	snek.paused = false
	
func debug_string() -> String:
	return "WinCommand"
