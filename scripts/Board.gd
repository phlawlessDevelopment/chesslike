extends TileMap

var units = [] 
var p1_units = [] 
var p2_units = [] 
var initiative := 1
var active := true
var this_initiative = []
var coins :=[]
var units_to_act_count := 0
onready var gui = get_tree().root.get_node("Sandbox/GUI")

func _ready():
	units = get_tree().get_nodes_in_group("units")
	for unit in units:
		if unit.player_index == 0:
			p1_units.append(unit)
		else:
			p2_units.append(unit)
	coins = get_tree().get_nodes_in_group("coins")
	units.sort_custom(self, "sort_by_init")
	set_process(false)
	
func _input(event):
	if event.is_action_pressed("space"):
		start_turn()

func _process(_delta):
	if !active:
		return
	var steps_remaining := false
	for unit in units:
		if !unit.has_acted and unit.initiative == initiative:
			steps_remaining = unit.step()
			if !steps_remaining:
				units_to_act_count -= 1
	
	$Timer.start(0.25)
	active = false
	yield($Timer, "timeout")
	active = true

	if !steps_remaining:
		for unit in units:
			if unit.initiative == initiative:
				pickup_coin(unit)
				take_piece(unit)
		if units_to_act_count == 0:
			set_process(false)
		initiative +=1

func start_turn():
	initiative = 1
	for unit in units:
		unit.has_acted = false
	units_to_act_count = units.size()
	set_process(true)

func pickup_coin(unit):
	for coin in coins:
		if unit.global_position.distance_to(coin.global_position) < 10:
			coins.erase(coin)
			coin.queue_free()
			gui.add_coin(unit.player_index)

func take_piece(unit):
	if unit.player_index == 0:
		for other in p2_units:
			if unit.global_position.distance_to(other.global_position) < 10:
				p2_units.erase(other)
				units.erase(other)
				if !other.has_acted:
					units_to_act_count -=1
				other.queue_free()
				gui.add_kill(unit.player_index)
	else:
		for other in p1_units:
			if unit.global_position.distance_to(other.global_position) < 10:
				p1_units.erase(other)
				units.erase(other)
				if !other.has_acted:
					units_to_act_count -=1
				other.queue_free()
				gui.add_kill(unit.player_index)

func sort_by_init(a, b):
	if typeof(a) != typeof(b):
		return typeof(a) < typeof(b)
	else:
		return a.initiative < b.initiative
