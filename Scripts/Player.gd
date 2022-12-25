extends CharacterBody2D
class_name Player

const SPEED = 10
var direction = Vector2.RIGHT

func get_next_offset ():
	return ALGlobal.GetTileSize() * direction

func _unhandled_input (event):
	if event is InputEventKey:
		if event.pressed:
			var old_direction = direction
			match event.keycode:
				KEY_W: direction = Vector2.UP
				KEY_A: direction = Vector2.LEFT
				KEY_S: direction = Vector2.DOWN
				KEY_D: direction = Vector2.RIGHT
			if direction != old_direction:
				ALSignals.player_direction_changed.emit()

func _draw ():
	draw_dashed_line(Vector2.ZERO, get_next_offset(), Color.WHITE, 5.0, 5.0)
	draw_rect(
		Rect2(
			Vector2.ZERO - ALGlobal.GetTileSize() / 2.0,
			ALGlobal.GetTileSize()
		),
		Color.WHITE,
		false,
		5.0
	)

func _process (delta):
	queue_redraw()

#
#
# Public
#
#

func Advance ():
	var collision = move_and_collide(get_next_offset())
	if collision != null:
		position = ALGlobal.GetTiledPosition(position)
		ALSignals.player_died.emit()
