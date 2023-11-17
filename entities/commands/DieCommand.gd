extends AutoTriggeredCommand

class_name DieCommand

func do(level: Level, snek: Snek) -> void:
	snek.paused = true
	snek.play_death_sound()
	snek.died.emit()
	
func undo(level: Level, snek: Snek) -> void:
	snek.paused = false
	
func debug_string() -> String:
	return "DieCommand"
