extends PanelContainer

class_name StuckPrompt

@export var cause_label : Label

func open(cause: Globals.GameOverCause) -> void:
	visible = true
	match cause:
		Globals.GameOverCause.STUCK:
			cause_label.text = "You're stuck!"
		Globals.GameOverCause.DEAD:
			cause_label.text = "You're dead!"
		
	$Timeout.start()
	
func _on_timeout_timeout() -> void:
	visible = false
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("rewind"):
		visible = false
