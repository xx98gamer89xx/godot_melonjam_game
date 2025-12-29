extends Area2D
var mask
var wanted_mask = 3
func _ready():
	if mask == null:
		mask = wanted_mask

	
