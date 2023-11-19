extends Mob

@export var sprite : Texture

func _ready() -> void:
	super._ready()
	assert(sprite)
	$Sprite2D.texture = sprite

	
func snek_can_enter() -> bool:
	return false
	
