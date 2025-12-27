extends Area2D
var velocity = Vector2(0, 0)
var max_velocity = 50
var force = 10
var axis_velocity
var gun = load("res://item.tscn")
var allow_movement
var there_is_item
var mask
var can_rotate
var nearby_item
var animation
@onready var attack_timer = $Timer
func _ready():
	mask = 0
	there_is_item = false
	allow_movement = true
	can_rotate = true
	pass
	
func _process(delta):
	## Local Movement Logic
	velocity = Vector2.ZERO
	var W= _movement_axis()[0]
	var Wn = _movement_axis()[1]
	if Input.is_action_pressed("a") and allow_movement == true:
		force = 7.5
		velocity += -Wn.normalized()
	if Input.is_action_pressed("d") and allow_movement == true:
		force = 7.5
		velocity += Wn.normalized()
	if Input.is_action_pressed("w") and allow_movement == true:
		force = 10
		velocity += W.normalized()
	if Input.is_action_pressed("s") and allow_movement == true:
		force = 5
		velocity += -W.normalized()
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized()
		position += velocity * force
	## Looking mouse
	var mouse_position = get_global_mouse_position()
	if can_rotate == true:
		look_at(mouse_position)
	## Attack
	if Input.is_action_just_pressed("space"):
		var gun_instance = gun.instantiate()
		gun_instance.position = Vector2(100, 0)
		if there_is_item == false:
			add_child(gun_instance)
	there_is_item = false
	for i in get_children():
		if i.is_in_group("items"):
			there_is_item = true
			break

	if there_is_item == true or animation == true:
		allow_movement = false
		can_rotate = false
	else:
		allow_movement = true
		can_rotate = true
	
	## Pickup mask
	if Input.is_action_just_pressed("e"):
		if nearby_item != null:
			if nearby_item.is_in_group("masks"):
				$AnimationPlayer.play("take mask")
				animation = true
				var mask_instance = preload("res://mask.tscn").instantiate()
				mask_instance.position = nearby_item.position
				mask_instance.mask = mask
				add_sibling(mask_instance)
				print(nearby_item.mask)
				mask = nearby_item.mask
				nearby_item.queue_free()
				nearby_item = null

func _movement_axis():
	var AB = Vector2(position.x + cos(rotation), position.y) - position
	var BC = Vector2(position.x + cos(rotation), position.y + sin(rotation)) - Vector2(position.x + cos(rotation), position.y)
	var W = AB + BC
	return [W, Vector2(-W.y, W.x)]
	


func _on_area_entered(area: Area2D) -> void:
	nearby_item = area


func _on_area_exited(area: Area2D) -> void:
	if area == nearby_item:
		nearby_item = null


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation = false
	pass # Replace with function body.
