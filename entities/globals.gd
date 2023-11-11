extends RefCounted

class_name Globals

enum GameOverCause { STUCK, DEAD }

const TURN_LENGTH := 0.3

const TILE_SIZE = 12
const TILE_SIZE_2D = Vector2i(TILE_SIZE, TILE_SIZE)
const TILE_CENTER_OFFSET = Vector2i(TILE_SIZE, TILE_SIZE) / 2

const UP = Vector2i(0, -1)
const DOWN = Vector2i(0, 1)
const LEFT = Vector2i(-1, 0)
const RIGHT = Vector2i(1, 0)
