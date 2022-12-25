extends CanvasLayer

var deaths = 0
var keypresses = 0

func _unhandled_input (event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_SPACE:
				if $Control/Start.visible:
					$Control/Start.visible = false
					ALSignals.level_start.emit()

func _ready ():
	process_mode = Node.PROCESS_MODE_ALWAYS
	ALSignals.level_changed.connect(func (level):
		$Control/BottomBar/HBoxContainer/Level/Label.text = str(level)
		$Control/Start/Label.text = "Start"
		$Control/Start.visible = true
	)
	ALSignals.game_ended.connect(func ():
		get_tree().paused = true
		$Control/End.visible = true
	)
	ALSignals.player_died.connect(func ():
		deaths += 1
		$Control/BottomBar/HBoxContainer/Deaths/Label.text = str(deaths)
		$Control/Start/Label.text = "Restart"
		$Control/Start.visible = true
	)
	ALSignals.player_direction_changed.connect(func ():
		keypresses += 1
		$Control/BottomBar/HBoxContainer/Keypresses/Label.text = str(keypresses)
	)
