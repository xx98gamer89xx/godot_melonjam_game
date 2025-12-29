extends RigidBody2D
var allow_movement
var objective
var times_played
var route
var i
var following_object
var mask
var can_see
var attacking
var health
signal door(door_name)
func _ready():
	i = 0
	times_played = 0
	allow_movement = true
	sleeping = false
	route = [Vector2(460, 0), Vector2(500, 500)]
	mask = 7
	can_see = true
	health = 5
	change_mask()

func change_mask():
	if mask == 3:
		$Sprite2D.texture = load("res://sprites/enemigo mascara kitsune ojos azules-export.png")
	if mask == 4:
		$Sprite2D.texture = load("res://sprites/enemigo kitsune azul cuchillada - copia - copia.png")
	if mask == 5:
		$Sprite2D.texture = load("res://sprites/enemigo mascara kitsune verde.png")
	if mask == 6:
		$Sprite2D.texture = load("res://sprites/enemigo kitsune verde cuchillada - copia - copia.png")
	if mask == 7:
		$Sprite2D.texture = load("res://sprites/enemigo mascara kitsune rosa - copia.png")
	if mask == 8:
		$Sprite2D.texture = load("res://sprites/enemigo kitsune rosa cuchillada.png")
	if mask == 9:
		$Sprite2D.texture = load("res://sprites/enemigo mascara oni azul - copia - copia.png")
	if mask == 10:
		$Sprite2D.texture = load("res://sprites/enemigo oni azul cuchillada.png")
	if mask == 11:
		$Sprite2D.texture = load("res://sprites/enemigo mascara oni verde - copia - copia.png")
	if mask == 12:
		$Sprite2D.texture = load("res://sprites/enemigo oni verde cuchillada.png")
	if mask == 13:
		$Sprite2D.texture = load("res://sprites/enemigo mascara oni rosa - copia - copia.png")
	if mask == 14:
		$Sprite2D.texture = load("res://sprites/enemigo oni rosa cuchillada.png")
	if mask == 15:
		$Sprite2D.texture = load("res://sprites/enemigo mascara samurai.png")
	if mask == 16:
		$Sprite2D.texture = load("res://sprites/enemigo samurai cuchillada.png")

func raycast():
	if $RayCast2D.get_collider() != null:
		if $RayCast2D.get_collider().is_in_group("doors"):
			if $RayCast2D.get_collider().open == false:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
				emit_signal("door", $RayCast2D.get_collider().name)
		if $RayCast2D.get_collider().is_in_group("wall"):
			can_see = false
		else:
			can_see = true
		if $RayCast2D.get_collider().is_in_group("objectives"):
			attack()

func allowing_movement():
	if allow_movement == true:
		var W = _movement_axis()[0]
		linear_velocity = 300 * W.normalized()
	else:
		linear_velocity = Vector2(0, 0)

func objectives():
	if objective != null:
		look_at(objective)
		if position.distance_to(objective) < 10:
			if times_played < 2:
				allow_movement = false
				linear_velocity = Vector2(0, 0)
				if $AnimationPlayer.is_playing() == false:
					$AnimationPlayer.play("looking_around")
			if times_played >= 2:
				follow_path()
	else:
		follow_path()
func die():
	var mask_instance = load("res://mask.tscn").instantiate()
	mask_instance.mask = mask
	mask_instance.position = position
	add_sibling(mask_instance)
	queue_free()
func _physics_process(delta):
	if health <= 0:
		die()
	if mask == 1:
		$AnimatedSprite2D.frame = 0		
	raycast()
	if following_object != null:
		objective = following_object.get_parent().position
	objectives()
	allowing_movement()

func _movement_axis():
	var AB = Vector2(position.x + cos(rotation), position.y) - position
	var BC = Vector2(position.x + cos(rotation), position.y + sin(rotation)) - Vector2(position.x + cos(rotation), position.y)
	var W = AB + BC
	return [W, Vector2(-W.y, W.x)]

func follow_path():
	times_played = 0
	allow_movement = true
	objective = route[i]
	i += 1
	if i > len(route) - 1:
		i = 0

func attack():
	allow_movement = false
	if attacking != null:
		attacking.get_parent().health -= 5
	allow_movement = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	times_played += 1


func _on_lantern_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives") and area.get_parent().mask < mask and can_see == true and area.name == "enemy_collider":
		following_object = area
		allow_movement = true
func _on_lantern_area_exited(area: Area2D) -> void:
	if area.is_in_group("objectives") and can_see == true:
		if following_object != null:
			objective = following_object.get_parent().position
			following_object = null


func _on_attack_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives"):
		attacking = area

func _on_attack_area_exited(area: Area2D) -> void:
	if area.is_in_group("objectives"):
		attacking = null
