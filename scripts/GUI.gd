extends Control

onready var p1_kills_display = $Panel/P1/p1_kills/count
onready var p1_coins_display = $Panel/P1/p1_coins/count

var p1_kills :=0
var p1_coins :=0

onready var p2_kills_display = $Panel/P2/p2_kills/count
onready var p2_coins_display = $Panel/P2/p2_coins/count

var p2_kills :=0
var p2_coins :=0

export(Array, Texture) var number_textures

func _ready():
	pass

func add_kill(player):
	if player == 0:
		p1_kills +=1
		p1_kills_display.visible = true
		p1_kills_display.texture = number_textures[p1_kills-1]
	else:
		p2_kills +=1
		p2_kills_display.visible = true
		p2_kills_display.texture = number_textures[p2_kills-1]

func add_coin(player):
	if player == 0:
		p1_coins +=1
		p1_coins_display.visible = true
		p1_coins_display.texture = number_textures[p1_coins-1]
	else:
		p2_coins +=1
		p2_coins_display.visible = true
		p2_coins_display.texture = number_textures[p2_coins-1]
