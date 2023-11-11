extends Node2D

class_name Level

@export var starting_direction : Vector2i = Globals.UP
@export var starting_size := 3

var tutorial_manager : TutorialManager

signal eaten
signal moved
signal exited

# number of cheesebois at level start
var starting_cheeseboi_count = -1

var cheesebois_eaten = 0
var step_count = 0

var level_name := "Unnamed"
var level_id := "undefined"

func _ready() -> void:
	assert($Snek)
	assert($TileMap)
	assert($Mobs)
	assert($Mobs/Flag)
	spawn_snake()
	starting_cheeseboi_count = count_cheesebois()
	
func spawn_snake() -> void:
	var snek = $Snek as Snek
	var location = find_flag()
	var cells : Array[Vector2i] = [
		location, 
		location - starting_direction, 
		location - 2*starting_direction
	]
	
	snek.coords = cells
	snek.update_sprites()
	snek.moved.connect(self._on_snake_moved)
	snek.eaten.connect(self._on_eaten)
	
func find_flag() -> Vector2i:
	var flag = $Mobs/Flag as Flag
	return flag.coords

func can_move_to(coords: Vector2i) -> bool:
	var tile = get_tile_map().get_cell_tile_data(0, coords)
	if tile:
		return tile.get_custom_data("walkable")
	else:
		return false
	
func is_cheeseboi(coords: Vector2i) -> bool:
	for m in $Mobs.get_children():
		var mob = m as Mob
		if mob.get_rect().has_point(coords):
			return true
			
	return false
		
func count_cheesebois() -> int:
	var counter = 0
	for m in $Mobs.get_children():
		if is_instance_of(m, Cheeseboi):
			counter += 1
			
	return counter
	
func get_flag() ->  Flag:
	return $Mobs/Flag as Flag

func is_exit(coords: Vector2i) -> bool:
	return get_flag().coords == coords

func get_tile_map() -> TileMap:
	assert($TileMap)
	return $TileMap
	
func get_hud() -> HUD:
	return get_parent().get_node("HUD") as HUD
	
func get_mobs() -> Array[Mob]:
	var result : Array[Mob] = []
	for mob in $Mobs.get_children():
		result.append(mob as Mob)
		
	return result
	
func add_mob(mob: Mob) -> void:
	$Mobs.add_child(mob)
	
func remove_mob(mob: Mob) -> void:
	$Mobs.remove_child(mob)

func _on_eaten() -> void:
	eaten.emit()

func _on_snake_moved() -> void:
	moved.emit()
	
func get_score() -> int:
	return floor((cheesebois_eaten * 1000) - (step_count * 10))
	
func get_level_name() -> String:
	return level_name

func _show_tutorials() -> void:
	pass # to be overridden in child classes
