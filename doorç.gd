extends StaticBody2D
var open
var mask = null
func _ready():
	open = false
	for nodo in get_parent().get_children():
		if nodo.is_in_group("openers"):
			nodo.connect("door", _door)
	
func _process(delta):
	pass


func _door(door_name):
	if door_name == name:
		print("Soy yo")
		if open == false:
			$AnimationPlayer.play("opening")
			open = true
		else:
			$AnimationPlayer.play("closing")
			open = false
		
	
