extends Button
func _ready():
	Gamepad.level += 0 

func _on_button_down() -> void:
	Gamepad.level += 1 
	if Gamepad.level == 1:
		print("Nivel 1")
		get_tree().change_scene_to_file("res://level_1.tscn")
	if Gamepad.level == 2:
		get_tree().change_scene_to_file("res://level2.tscn")
	if Gamepad.level == 3:
		get_tree().change_scene_to_file("res://level3.tscn")


func _on_button_2_button_down() -> void:
	get_tree().quit()
