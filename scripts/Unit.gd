extends Node2D

export(Array, Texture) var initiative_textures
export(Array, Texture) var direction_textures
export var player_index := 0 setget set_index
export var initiative := 1 setget set_initiative

var colors :=[Color(0,1,0),Color(0,0,1)]
var direction_vectors := [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]

enum DIRECTION { left,up,right,down }
export(Array,DIRECTION) var directions

var dir_indicator = preload("res://scenes/prefabs/direction_indicator.tscn")

func _ready():
	yield(get_tree().root, "ready")
	var indicator_offset = Vector2(0,0)
	for dir in directions:
		var indicator = dir_indicator.instance()
		$directions.add_child(indicator)
		indicator.global_position+= indicator_offset
		indicator_offset.y -= 10
		indicator.skin = direction_textures[dir]

	$bg.modulate = colors[player_index]
	
	
func set_index(i):
	$bg.modulate = colors[i]


func set_initiative(i):
	$init.texture = initiative_textures[i-1]

func step():
	if directions.size() < 1 :
		return false
	var dir = directions.pop_front()
	global_position += direction_vectors[dir] * 54
	return true
