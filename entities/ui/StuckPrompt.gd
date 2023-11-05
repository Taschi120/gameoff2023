extends PanelContainer

class_name StuckPrompt

func open() -> void:
	visible = true
	$Timeout.start()
	
func _on_timeout_timeout() -> void:
	visible = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("rewind"):
		visible = false
