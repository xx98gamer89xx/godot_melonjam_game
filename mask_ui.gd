extends Control
var player
func _ready():
	for node in get_parent().get_parent().get_children():
		if node.name == "RigidBody2D":
			player = node

func _process(delta):
	if player != null:
		if player.mask == 0 or player.mask == 1:
			$TextureRect.texture = load("res://sprites/cara.png")
		if player.mask == 2 or player.mask == 3:
			$TextureRect.texture = load("res://sprites/mascara kitsune azul.png")
		if player.mask == 4 or player.mask == 5:
			$TextureRect.texture = load("res://sprites/mascara kitsune verde.png")
		if player.mask == 6 or player.mask == 7:
			$TextureRect.texture = load("res://sprites/mascara kitsune rosa.png")
		if player.mask == 8 or player.mask == 9:
			$TextureRect.texture = load("res://sprites/mascara oni azul.png")
		if player.mask == 10 or player.mask == 11:
			$TextureRect.texture = load("res://sprites/mascara oni verde.png")
		if player.mask == 11 or player.mask == 13:
			$TextureRect.texture = load("res://sprites/mascara oni rosa.png")
		if player.mask == 14 or player.mask == 15:
			$TextureRect.texture = load("res://sprites/mascara samurai.png")
