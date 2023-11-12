extends Mob

class_name Car

const colors = [
	Color.RED,
	Color.SILVER,
	Color.AQUA,
	Color.GREEN,
	Color.YELLOW,
]

func _ready() -> void:
	var i = randi_range(0, colors.size() - 1)
	$Sprite2D.modulate = colors[i]

func take_turn(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return [MobMoveCommand.new(self)]
	
func collide_with_snek_head(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return kill_snek()
	
func collide_with_snek_body(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return kill_snek()
	
func kill_snek() -> Array[AutoTriggeredCommand]:
	return [DieCommand.new()]
