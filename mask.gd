extends Area2D
var mask
var wanted_mask = 3
func _ready():
	if mask == null:
		mask = wanted_mask
	if mask == 3:
		$Sprite2D.texture = load("res://sprites/mascara kitsune azul.png")
	if mask == 5:
		$Sprite2D.texture = load("res://sprites/mascara kitsune verde.png")
	if mask == 7:
		$Sprite2D.texture = load("res://sprites/mascara kitsune rosa.png")
	if mask == 9:
		$Sprite2D.texture = load("res://sprites/mascara oni azul.png")
	if mask == 11:
		$Sprite2D.texture = load("res://sprites/mascara oni verde.png")
	if mask == 13:
		$Sprite2D.texture = load("res://sprites/mascara oni rosa.png")
	if mask == 15:
		$Sprite2D.texture = load("res://sprites/mascara samurai.png")
	
	
	
