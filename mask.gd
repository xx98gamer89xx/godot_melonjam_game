extends Area2D
var mask
var wanted_mask = 1
func _ready():
	if mask == null:
		mask = wanted_mask
	print(mask)
