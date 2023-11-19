extends Node2D

class_name Mob

@export var coords: Vector2i : set = set_coords
@export var size: Vector2i = Vector2i(1, 1)

@export var movement: MobMovement

func _ready() -> void:
	# determine cell position based on location
	var px : int = floor(position.x) - (Globals.TILE_SIZE / 2)
	var py : int = floor(position.y) - (Globals.TILE_SIZE / 2)
	
	assert(px % Globals.TILE_SIZE == 0)
	assert(py % Globals.TILE_SIZE == 0)
	
	set_coords(Vector2i(px / Globals.TILE_SIZE, py / Globals.TILE_SIZE))
	
func get_rect() -> Rect2i:
	return Rect2i(coords, size)
	
func contains_point(_coords: Vector2i) -> bool:
	return _coords.x >= coords.x and _coords.x < coords.x + size.x and \
		_coords.y >= coords.y and _coords.y < coords.y + size.y
	
func set_coords(_coords: Vector2i) -> void:
	coords = _coords
	var new_position = Vector2((coords * Globals.TILE_SIZE) + Globals.TILE_CENTER_OFFSET)
	var tween = self.create_tween()
	# tween will be null when called from _ready
	if (tween):
		tween.tween_property(self, "position", new_position, Globals.TURN_LENGTH)
	else:
		position = new_position
		
# determines if the snake can enter the tile(s) occupied by this mob
func snek_can_enter() -> bool:
	return true
	
func take_turn(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return []

func collide_with_snek_head(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return []
	
func collide_with_snek_body(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	return []
