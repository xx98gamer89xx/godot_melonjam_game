extends Button


func _on_button_down() -> void:
	Gamepad.level += 1
	if Gamepad.level == 1:
		get_tree().change_scene_to_file("res://test.tscn")
	if Gamepad.level == 2:
		get_tree().change_scene_to_file("res://test.tscn")
	if Gamepad.level == 3:
		get_tree().change_scene_to_file("res://test.tscn")


func _on_button_2_button_down() -> void:
	get_tree().quit()
