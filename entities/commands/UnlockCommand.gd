extends AutoTriggeredCommand

class_name UnlockCommand

var target: Lock

func _init(_target: Lock) -> void:
	assert(_target)
	target = _target

func can_do(_level: Level, snek: Snek) -> bool:
	return snek.coords.size() >= target.required_size
	
func do(_level: Level, snek: Snek) -> void:
	target.locked = false

func undo(_level: Level, _snek: Snek) -> void:
	target.locked = true
	
func debug_string() -> String:
	return "UnlockCommand (%d, %d)" % [target.coords.x, target.coords.y]
