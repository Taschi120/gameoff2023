extends Mob

class_name Lock

@export_range(3, 100)
var required_size := 4

@export var locked_texture: CompressedTexture2D
@export var unlocked_texture: CompressedTexture2D

var locked = true : set = set_locked

@onready var lock_sprite := $LockSprite as Sprite2D
@onready var counter_label := $Label as Label

var tween : Tween = null

func _ready() -> void:
	counter_label.text = str(required_size)

func set_locked(value: bool) -> void:
	locked = value
	if locked:
		lock_sprite.texture = locked_texture
		tween.kill()
		lock_sprite.modulate = Color.WHITE
		counter_label.modulate = Color.WHITE
	else:
		lock_sprite.texture = unlocked_texture
		make_tween()
		tween.parallel().tween_property(lock_sprite, "modulate", Color.TRANSPARENT, 0.5)
		tween.parallel().tween_property(counter_label, "modulate", Color.TRANSPARENT, 0.5)

func snek_can_enter() -> bool:
	return not locked
	
func take_turn(_level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	if locked and snek.coords.size() >= required_size:
		return [UnlockCommand.new(self)]
	else:
		return []
		
func make_tween() -> Tween:
	if tween:
		tween.kill()
	tween = create_tween()
	return tween
