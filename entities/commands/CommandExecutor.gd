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

func rewind() -> void:
	if stack.is_empty():
		return
	var command = stack.pop_back()
	print("Rewinding command %s" % command.debug_string())
	command.undo(level, snek)
