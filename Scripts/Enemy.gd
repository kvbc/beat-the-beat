extends CharacterBody2D

enum MoveType {
	LEFT_RIGHT,
	RIGHT_LEFT,
	UP_DOWN,
	DOWN_UP
}

@export var move_type := MoveType.UP_DOWN
var direction

func _ready ():
	position = ALGlobal.GetTiledPosition(position)
	match move_type:
		MoveType.LEFT_RIGHT: direction = Vector2.LEFT
		MoveType.RIGHT_LEFT: direction = Vector2.RIGHT
		MoveType.UP_DOWN   : direction = Vector2.UP
		MoveType.DOWN_UP   : direction = Vector2.DOWN

#
#
# Public
#
#

func Advance ():
	var collision = move_and_collide(ALGlobal.GetTileSize() * direction)
	if collision != null:
		position = ALGlobal.GetTiledPosition(position)
		if collision.get_collider() is Player:
			ALSignals.player_died.emit()
		else:
			direction *= -1
