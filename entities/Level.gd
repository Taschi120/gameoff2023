extends Node2D

class_name Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert($Snek)
	assert($TileMap)
	$Snek.level = self

func can_move_to(coords: Vector2i) -> bool:
	var tile = get_tile_map().get_cell_tile_data(0, coords)
	var walkable = tile.get_custom_data("walkable") as bool
	return walkable
	
func get_tile_map() -> TileMap:
	assert($TileMap)
	return $TileMap
