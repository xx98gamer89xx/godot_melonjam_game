extends Area2D
var damage = 5
var time = 0.5
func _ready():
	$time.wait_time = time
	$time.start()
	add_to_group("items")
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().health -= damage
	pass # Replace with function body.
func _on_time_timeout():
	get_parent().mask -= 1
	queue_free()
