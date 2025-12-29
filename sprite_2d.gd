extends Sprite2D
func _process(delta):
	var mask = get_parent().get_parent().mask
	print(mask)
	if mask == 0:
		texture = load("res://sprites/prota sin mascara.png")
	if mask == 1:
		texture = load("res://sprites/prota sin mascara cuchillada.png")
	if mask == 2:
		texture = load("res://sprites/prota mascara kitsune ojos azules.png")
	if mask == 3:
		texture = load("res://sprites/prota mascara kitsune azul cuchillada.png")
	if mask == 4:
		texture = load("res://sprites/prota mascara kitsune ojos verdes.png")
	if mask == 5:
		texture = load("res://sprites/prota mascara kitsune verde cuchillada.png")
	if mask == 6:
		texture = load("res://sprites/prota mascara kitsune ojos rosas.png")
	if mask == 7:
		texture = load("res://sprites/prota mascara kitsune rosa cuchillada.png")
	if mask == 8:
		texture = load("res://sprites/prota mascara oni ojos azules.png")
	if mask == 9:
		texture = load("res://sprites/prota mascara oni azules cuchillada.png")
	if mask == 10:
		texture = load("res://sprites/prota mascara oni ojos verdes.png")
	if mask == 11:
		texture = load("res://sprites/prota mascara oni verdes cuchillada.png")
	if mask == 12:
		texture = load("res://sprites/prota mascara oni ojos rosas.png")
	if mask == 13:
		texture = load("res://sprites/prota mascara oni rosa cuchillada.png")
	if mask == 14:
		texture = load("res://sprites/prota mascara samurai.png")
	if mask == 15:
		texture = load("res://sprites/prota mascara samurai cuchillada.png")
