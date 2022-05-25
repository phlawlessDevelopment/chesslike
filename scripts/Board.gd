extends TileMap

var units = [] 
var initiative := 1
var active := false
var this_initiative = []

func _ready():
	units = get_tree().get_nodes_in_group("units")
	units.sort_custom(self,"sort_by_init")
	set_process(false)
	
func _input(event):
	if event.is_action_pressed("space"):
		initiative = 1
		set_process(true)
			

func _process(delta):
	var units_still_to_move := false
	for unit in units:
		if unit.initiative == initiative:
			units_still_to_move =  unit.step()
			$Timer.start(1)
			yield($Timer,"timeout")
			
	set_process(units_still_to_move)


func sort_by_init(a, b):
	if typeof(a) != typeof(b):
		return typeof(a) < typeof(b)
	else:
		return a.initiative < b.initiative
