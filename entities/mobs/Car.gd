extends Mob

class_name Car

func take_turn(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return [MobMoveCommand.new(self)]
