extends Node2D

class_name Level

@export var starting_direction : Vector2i = Globals.UP
@export var starting_size := 3

var score = 0

func _ready() -> void:
	assert($Snek)
	assert($TileMap)
	spawn_snake()

	
func spawn_snake() -> void:
	var snek = $Snek as Snek
	var location = find_flag()
	var cells : Array[Vector2i] = [
		location, 
		location - starting_direction, 
		location - 2*starting_direction
	]
	
	snek.level = self
	snek.coords = cells
	snek.update_sprites()
	
func find_flag() -> Vector2i:
	var cells := get_tile_map().get_used_cells(1)
	for vector in cells:
		if get_tile_map().get_cell_tile_data(1, vector).get_custom_data("object") == "flag":
			return vector
			
	assert(false)
	return Vector2i.ZERO

func can_move_to(coords: Vector2i) -> bool:
	var tile = get_tile_map().get_cell_tile_data(0, coords)
	if tile:
		return tile.get_custom_data("walkable")
	else:
		return false
	
func is_cheeseboi(coords: Vector2i) -> bool:
	var tile = get_tile_map().get_cell_tile_data(1, coords)
	if tile:
		print("tile")
		return tile.get_custom_data("object") == "food"
	else: 
		return false
	
func remove_cheeseboi(coords: Vector2i) -> void:
	get_tile_map().set_cell(1, coords, -1)
	
func get_tile_map() -> TileMap:
	assert($TileMap)
	return $TileMap

func _on_eaten() -> void:
	score += 1
