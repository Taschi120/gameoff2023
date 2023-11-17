extends Node2D

class_name Snek

signal moved
signal eaten
signal trapped
signal died
signal level_exit_hit

var sprite_sheet: Texture = load("res://assets/sprites/snake-sprites.png")
var sprite_sheet_size := Vector2i(6, 1)

var command_executor: CommandExecutor

var paused := false

var last_tail_position: Vector2i = Vector2i.ZERO

# Snake parts
var BODY_STRAIGHT := RSprite.new(Vector2i(0,0), "straight")
var BODY_CORNER := RSprite.new(Vector2i(2, 0), "corner")
var SNOUT := RSprite.new(Vector2i(3, 0), "snout")
var TAIL := RSprite.new(Vector2i(5, 0), "tail")
var BLELELE := RSprite.new(Vector2i(1,0), "blelele")

# locations of snake
var coords: Array[Vector2i]

const MOVE_COOLDOWN = 0.3
var move_cooldown_timer = 0
	
func _input(event: InputEvent) -> void:
	if paused:
		return
		
	handle_movement_input(event)

func handle_movement_input(event: InputEvent) -> void:
	var now = Engine.get_process_frames()

	var moved = false
	if event.is_action_pressed("up"):
		try_move_snake(Globals.UP)
		moved = true
	elif event.is_action_pressed("down"):
		try_move_snake(Globals.DOWN)
		moved = true
	elif event.is_action_pressed("left"):
		try_move_snake(Globals.LEFT)
		moved = true
	elif event.is_action_pressed("right"):
		try_move_snake(Globals.RIGHT)
		moved = true
	elif event.is_action_pressed("rewind"):
		command_executor.rewind()
	elif event.is_action_pressed("blelele"):
		blelele()
		moved = true
		
	if moved:
		$InputTimer.start()
		
func handle_followup_movement() -> void:
	var moved = false
	if Input.is_action_pressed("up"):
		try_move_snake(Globals.UP)
		moved = true
	elif Input.is_action_pressed("down"):
		try_move_snake(Globals.DOWN)
		moved = true
	elif Input.is_action_pressed("left"):
		try_move_snake(Globals.LEFT)
		moved = true
	elif Input.is_action_pressed("right"):
		try_move_snake(Globals.RIGHT)
		moved = true
	elif Input.is_action_pressed("rewind"):
		command_executor.rewind()
		moved = true
	elif Input.is_action_pressed("blelele"):
		blelele()
		moved = true
		
	if moved:
		$InputTimer.start()
		
func blelele() -> void:
		$Sounds/Blelele.play()
		$AnimationPlayer.play("tongueflick")
		command_executor.execute(WaitCommand.new())
	
func try_move_snake(direction: Vector2i) -> void:
	assert(command_executor)
	assert(direction in [Globals.UP, Globals.DOWN, Globals.LEFT, Globals.RIGHT])
	var command = MoveCommand.new(coords[0] + direction)
	if command_executor.can_execute(command):
		command_executor.execute(command)
	else:
		$Sounds/Smash.play()

func play_food_sound() -> void:
	$Sounds/Krontsch.play()
	
func play_rewind_sound() -> void:
	$Sounds/Rewind.play()
	
func play_death_sound() -> void:
	$Sounds/Ded.play()
	
func update_sprites() -> void:
	assert(coords.size() >= 3)
	spawn_sprites_if_necessary()
	assert(coords.size() == $Sprites.get_child_count())
	
	for i in range(0, coords.size()):
		var sprite = $Sprites.get_child(i) as Sprite2D
		var tile_position = coords[i]
		
		# set appropriate location
		sprite.position = (tile_position * Globals.TILE_SIZE) + Globals.TILE_CENTER_OFFSET

		# set appropriate sprite
		if i == 0:
			sprite.frame_coords = SNOUT.coords
			var direction = coords[i] - coords[i + 1]
			sprite.rotation_degrees = get_head_rotation(direction)
			
			$Blelele.position = (tile_position + direction) * Globals.TILE_SIZE + Globals.TILE_CENTER_OFFSET
			$Blelele.rotation_degrees = sprite.rotation_degrees
			
		elif i == coords.size() - 1:
			sprite.frame_coords = TAIL.coords
			sprite.rotation_degrees = get_tail_rotation(coords[i] - coords[i - 1])
			
		else:
			var prev = coords[i] - coords[i - 1]
			var next = coords[i] - coords[i + 1]
			
			if prev + next == Vector2i.ZERO:
				sprite.frame_coords = BODY_STRAIGHT.coords
				sprite.rotation_degrees = get_straight_torso_rotation(prev, next)
				
			else:
				sprite.frame_coords = BODY_CORNER.coords
				sprite.rotation_degrees = get_corner_torso_rotation(prev, next)

func get_tail_rotation(prev: Vector2i) -> int:
	return get_head_rotation(prev) - 180

func get_head_rotation(next: Vector2i) -> int:
	match next:
		Globals.UP: return 0
		Globals.RIGHT: return 90
		Globals.DOWN: return 180
		Globals.LEFT: return 270
		
	assert(false)
	return 0

# determine rotation of straight torso sprite, based on direction to previous and next tile
func get_straight_torso_rotation(prev: Vector2i, _next: Vector2i) -> int:
	if prev.x == 0:
		return 0
	else:
		return 90
	
# determine rotation of corner torso sprite, based on direction to previous and next tile
func get_corner_torso_rotation(prev: Vector2i, next: Vector2i) -> int:
	var x_axis: Vector2i
	var y_axis: Vector2i

	if prev.x == 0:
		x_axis = next
		y_axis = prev
	else:
		x_axis = prev
		y_axis = next
		
	if x_axis == Globals.LEFT:
		if y_axis == Globals.UP:
			return 90
		else:
			return 0
			
	else:
		if y_axis == Globals.UP:
			return 180
		else:
			return 270
	
func prune() -> void:
	last_tail_position = coords[coords.size() - 1]
	coords.remove_at(coords.size() - 1)
	update_sprites()
	
func grow() -> void:
	coords.push_back(last_tail_position)
	update_sprites()

func spawn_sprites_if_necessary() -> void:
	while $Sprites.get_child_count() > coords.size():
		$Sprites.remove_child($Sprites.get_child(\
		$Sprites.get_child_count() - 1))
	while $Sprites.get_child_count() < coords.size():
		print("Making additional snake sprite")
		var sprite = Sprite2D.new()

		assert(sprite_sheet)
		sprite.texture = sprite_sheet
		sprite.hframes = sprite_sheet_size.x
		sprite.vframes = sprite_sheet_size.y
		
		sprite.frame_coords = BODY_STRAIGHT.coords # we'll set the correct value later
	
		$Sprites.add_child(sprite)

class RSprite:
	# Position of the sprite in the sprite sheet
	var coords: Vector2i
	var name: String
	
	func _init(_coords: Vector2i, _name: String):
		coords = _coords
		name = _name


func _on_blelele_timer_timeout() -> void:
	$Blelele.visible = false


func _on_input_timer_timeout() -> void:
	handle_followup_movement()
