extends Sprite

export(Texture) var skin setget set_texture

func set_texture(t):
	skin = t
	texture = t

func _ready():
	texture = skin


