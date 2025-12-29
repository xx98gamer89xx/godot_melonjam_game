extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives"):
		get_parent().get_child(0).get_child(1).text = "Be carefull, if you \n enter the lantern area, they will see you"
