extends Command

class_name AutoTriggeredCommand

func can_do(_level: Level, _snek: Snek) -> bool:
	# Because this command is not triggered from user interaction,
	# we can assume it is always possible, otherwise it wouldn't
	# have been triggered in the first place
	return true
