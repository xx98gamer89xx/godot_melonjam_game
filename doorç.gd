extends Area2D
var open
signal door
func _ready():
	open = false
	for nodo in get_tree().get_nodes_in_group("openers"):
		print(nodo.name)
		nodo.connect("door", Callable(self, "_door"))
	pass
	
	
func _process(delta):
	pass
func _door():
	print("hola")
	if open == false:
		$AnimationPlayer.play("opening")
		open = true
	else:
		$AnimationPlayer.play("closing")
		open = false
		
	
