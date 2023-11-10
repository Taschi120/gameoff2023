extends Node2D

class_name CommandExecutor

var level: Level
var snek: Snek

var stack: Array[Command] = []

signal eaten
signal moved

func can_execute(command: Command) -> bool:
	var result := command.can_do(level, snek)
	if result:
		print("Command %s is possible" % command.debug_string())
	else:
		print("Command %s is not possible" % command.debug_string())
	return result

func execute(command: Command) -> void:
	print("Executing command %s" % command.debug_string())
	command.do(level, snek)
	stack.append(command)
	
	if not is_instance_of(command, AutoTriggeredCommand):
		# let mobs take their turn
		for mob in level.get_mobs():
			var actions = mob.take_turn(level, snek)
			for action in actions:
				assert(is_instance_of(action, AutoTriggeredCommand))
				execute(action)
				
		# check for collisions
		for i in range(snek.coords.size()):
			var coord = snek.coords[i]
			print("checking collision at %s" % coord)
			for mob in level.get_mobs():
				if mob.get_rect().has_point(coord):
					var triggered_commands: Array[AutoTriggeredCommand]
					if i == 0:
						triggered_commands = mob.collide_with_snek_head(level, snek)
					else:
						triggered_commands = mob.collide_with_snek_body(level, snek)
						
					for triggered_command in triggered_commands:
						execute(triggered_command)
					

func rewind() -> void:
	if stack.is_empty():
		return
		
	var keep_running = true
	while keep_running and not stack.is_empty():
		var command = stack.pop_back()
		print("Rewinding command %s" % command.debug_string())
		command.undo(level, snek)
		# Rewind until we hit the first user interaction
		keep_running = is_instance_of(command, AutoTriggeredCommand)
