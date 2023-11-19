extends Mob

class_name Flag

func _ready() -> void:
	super._ready()

func collide_with_snek_head(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return [WinCommand.new()]
