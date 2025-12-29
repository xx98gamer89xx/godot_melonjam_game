extends RigidBody2D

var velocity = Vector2.ZERO
var max_velocity = 2000
var force = 1000
var gun = load("res://knife.tscn")
var allow_movement = true
var there_is_item = false
var mask
var can_rotate = true
var nearby_item = null
var animation = false
signal door(door_name)
var health
@onready var attack_timer = $Timer

func _ready():
	mask = 0
	health = 5
func _physics_process(delta):
	if health <= 0:
		you_died()
	# Reset velocity
	velocity = Vector2.ZERO

	if allow_movement:
		var W = _movement_axis()[0]
		var Wn = _movement_axis()[1]

		if Input.is_action_pressed("a"):
			force = 750 * 0.9
			velocity += -Wn.normalized()
		if Input.is_action_pressed("d"):
			force = 750 * 0.9
			velocity += Wn.normalized()
		if Input.is_action_pressed("w"):
			force = 1000 * 0.9
			velocity += W.normalized()
		if Input.is_action_pressed("s"):
			force = 500 * 0.9
			velocity += -W.normalized()

	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * force
	linear_velocity = velocity

	# Rotación mirando al mouse
	if can_rotate:
		var mouse_position = get_global_mouse_position()
		look_at(mouse_position)

	# Ataque
	if Input.is_action_just_pressed("space"):
		var gun_instance = gun.instantiate()
		gun_instance.position = Vector2(100, 0)
		if not there_is_item:
			add_child(gun_instance)
			mask += 1

	# Chequeo de items en children
	there_is_item = false
	for i in get_children():
		if i.is_in_group("items"):
			there_is_item = true
			break

	# Control de movimiento y rotación según estado
	if there_is_item or animation:
		$Node2D.get_child(0).frame += 1
		allow_movement = false
		can_rotate = false
	else:
		allow_movement = true
		can_rotate = true

	# Interacción con objetos
	if Input.is_action_just_pressed("e") and nearby_item != null:
		if nearby_item.is_in_group("masks"):
			$AnimationPlayer.play("take mask")
			mask += 1
			animation = true
			var mask_instance = preload("res://mask.tscn").instantiate()
			mask_instance.position = nearby_item.position
			mask_instance.mask = mask
			add_sibling(mask_instance)
			mask = nearby_item.mask
			nearby_item.queue_free()
			nearby_item = null
		elif nearby_item.is_in_group("doors"):
			print(nearby_item.get_parent())
			emit_signal("door", nearby_item.get_parent().name)

func _movement_axis():
	var AB = Vector2(position.x + cos(rotation), position.y) - position
	var BC = Vector2(position.x + cos(rotation), position.y + sin(rotation)) - Vector2(position.x + cos(rotation), position.y)
	var W = AB + BC
	return [W, Vector2(-W.y, W.x)]

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation = false
	mask -= 1

func you_died():
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	nearby_item = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area == nearby_item:
		nearby_item = null
