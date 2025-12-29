extends Node2D


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	z_index = 4
	if body.is_in_group("objectives"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
