extends AutoTriggeredCommand

class_name SpawnCommand

var spawner: MobSpawner

var spawned_mob: Mob

func _init(_spawner: MobSpawner) -> void:
	assert(_spawner)
	spawner = _spawner

	assert(spawner.mob_scene)

func do(level: Level, snek: Snek) -> void:
	assert(spawner.mob_movement)
	spawned_mob = spawner.mob_scene.instantiate() as Mob
	spawned_mob.set_coords(spawner.coords)
	spawned_mob.movement = spawner.mob_movement
	level.add_mob(spawned_mob)
	
func undo(level: Level, snek: Snek) -> void:
	level.remove_mob(spawned_mob)
	
func debug_string() -> String:
	return "SpawnCommand (%, %)" % [spawner.coords.x, spawner.coords.y]
