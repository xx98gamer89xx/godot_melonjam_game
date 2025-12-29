extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives"):
		get_parent().get_child(0).get_child(1).text = "Use e to take the mask, when yo have a mask,\n some agents won't attack you"
