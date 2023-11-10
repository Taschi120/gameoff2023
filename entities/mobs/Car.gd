extends Mob

class_name Car

func take_turn(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return [MobMoveCommand.new(self)]
	
func collide_with_snek_head(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return kill_snek()
	
func collide_with_snek_body(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return kill_snek()
	
func kill_snek() -> Array[AutoTriggeredCommand]:
	return [DieCommand.new()]
