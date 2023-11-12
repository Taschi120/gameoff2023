extends CenterContainer

@export_file var thirdparty_license_resource: String
@export var thirdparty_text_box: TextEdit

signal closed

func _on_button_pressed() -> void:
	closed.emit()
