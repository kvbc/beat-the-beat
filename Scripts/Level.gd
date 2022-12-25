extends Node2D

@export var BPM = 125.0
@export var SPEED = 1.0
var SECONDS_PER_BEAT = null

var player = null
var reset = false
var last_beat_num = 0

func advance ():
	player.Advance()
	await get_tree().physics_frame
	await get_tree().physics_frame
	if reset:
		ALGlobal.GetDeathSound().play()
		get_tree().reload_current_scene()
	for enemy in $Enemies.get_children():
		enemy.Advance()

func reset_beat ():
	$Beat.play()
	last_beat_num = -1

func _ready ():
	BPM *= SPEED
	$Beat.pitch_scale = SPEED
	SECONDS_PER_BEAT = 60.0 / BPM
	
	player = preload("res://Scenes/Player.tscn").instantiate()
	add_child(player)
	
	$Start.position = ALGlobal.GetTiledPosition($Start.position)
	$Finish.position = ALGlobal.GetTiledPosition($Finish.position)
	$Player.position = $Start.position
	
	ALSignals.player_died.connect(func ():
		reset = true	
	)
	
	$Beat.finished.connect(reset_beat)
	ALSignals.level_start.connect(func ():
		$Beat.play()
	)
	

func _process (delta):
	var beat_pos = $Beat.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency()
	var beat_num = int(floor(beat_pos / SECONDS_PER_BEAT))
	if beat_num > last_beat_num:
		advance()
		last_beat_num = beat_num

#
#
# Public
#
#

func GetTileMap ():
	return $TileMap
