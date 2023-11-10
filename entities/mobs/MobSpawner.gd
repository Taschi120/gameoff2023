extends Mob

class_name MobSpawner

# how often does a spawn happen?
@export var frequency := 4
# how long until the first spawn?
@export var lead_in := 0

# the scene to spawn
@export var mob_scene : PackedScene
@export var mob_movement : MobMovement : set = set_mob_movement

var countdown : int

func _ready():
	super._ready()
	assert(frequency > 0)
	assert(lead_in >= 0)
	assert(mob_scene)
	assert(mob_movement)
	
	countdown = lead_in
	
func set_mob_movement(value: MobMovement) -> void:
	assert(value)
	mob_movement = value


func take_turn(level: Level, snek: Snek) -> Array[AutoTriggeredCommand]:
	var result: Array[AutoTriggeredCommand]
	if countdown == 0:
		result = [SpawnCommand.new(self)]
		countdown = frequency
	else:
		result = []
		
	countdown -= 1
	return result
