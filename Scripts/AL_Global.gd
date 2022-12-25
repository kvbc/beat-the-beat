extends Node

var level = 1

func get_level_tilemap ():
	return get_tree().current_scene.GetTileMap()

func set_level (lvl):
	level = lvl
	var err = get_tree().change_scene_to_file("res://Scenes/Levels/%d.tscn" % level)
	if err != OK:
		ALSignals.game_ended.emit()
	else:
		ALSignals.level_changed.emit(level)

func _ready ():
	set_level(level)

#
#
# Public
#
#

func AdvanceLevel ():
	set_level(level + 1)

func GetDeathSound ():
	return $Death
	
func GetTiledPosition (pos):
	return get_level_tilemap().map_to_local(get_level_tilemap().local_to_map(pos))

func GetTileSize ():
	return Vector2(get_level_tilemap().tile_set.tile_size)
