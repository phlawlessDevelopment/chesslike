extends Node2D

export(Array, Texture) var initiative_textures
export(Array, Texture) var direction_textures
export var player_index := 0
export var initiative := 1 setget set_initiative

var colors :=[Color(0,1,0),Color(0,0,1)]
var direction_vectors := [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]

enum DIRECTION { left,up,right,down }
export(Array,DIRECTION) var directions
var direction_count :=0
var dir_indicator = preload("res://scenes/prefabs/direction_indicator.tscn")
var path_indicator = preload("res://scenes/prefabs/path_indicator.tscn")
var path_indicators := []
var has_acted := false

func _ready():
	yield(get_tree().root, "ready")
	var d_ind_offset = Vector2(0,0)
	
	for dir in directions:
		var dir_ind = dir_indicator.instance()
		$directions.add_child(dir_ind)
		dir_ind.global_position+= d_ind_offset
		d_ind_offset.y -= 10
		dir_ind.skin = direction_textures[dir]
		var p_ind = path_indicator.instance()
		$path.add_child(p_ind)
		path_indicators.append(p_ind)
	toggle_path()
	$bg.modulate = colors[player_index]

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.position.distance_to(global_position) < 50:
			toggle_path()

func toggle_path():
	$path.visible = !$path.visible
	if $path.visible:
		var p_ind_offset = Vector2(0,0)
		for i in range(path_indicators.size()):
			p_ind_offset += direction_vectors[directions[i]] * 54
			path_indicators[i].position = p_ind_offset

func set_initiative(i):
	$init.texture = initiative_textures[i-1]
	initiative = i

func step():
	global_position += direction_vectors[directions[direction_count]] * 54
	direction_count += 1
	print(name)
	print(direction_count)
	print(directions.size())
	if direction_count == directions.size():
		direction_count = 0
		has_acted = true
		return false
	return true

func bump(dir):
	global_position += dir * 54
