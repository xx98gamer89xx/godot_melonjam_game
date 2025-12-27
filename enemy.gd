extends Area2D
var objective
var velocity = Vector2(0, 0)
var W
var times_played
var allow_movement
var animation_rotation
var i
var health
var mask
var can_see
var route = [Vector2(0, 0), Vector2(500, 500), Vector2(1000, 0)]
@onready var forget = $forget
func _ready():
	times_played = 0
	allow_movement = true
	i = 0
	health = 5
	mask = 1
	can_see = true
	
	
func _process(delta):
	## Know if there is something blocking vision
	can_see = true
	if $RayCast2D.is_colliding() == true:
		if $RayCast2D.get_collider().is_in_group("wall"):
			can_see = false
	## Movement forward
	if health <= 0:
		var mask_instance = load("res://mask.tscn").instantiate()
		mask_instance.position = position
		mask_instance.mask = mask
		add_sibling(mask_instance)
		queue_free()
	W = _movement_axis()[0]
	velocity += W.normalized()
	velocity = velocity.normalized()
	if allow_movement == true:
		position += velocity * 7

	# Animate rotation
	rotation += get_node("rotator").rotation / 7
	if objective != null:
		if position.distance_to(objective) < 10:
			if times_played <= 1:
				if not $AnimationPlayer.is_playing():
					$AnimationPlayer.play("looking_around")
					allow_movement = false
			else:
				follow_path()
				allow_movement = true
				$AnimationPlayer.stop()
		else:
			look_at(objective)

func _on_lantern_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives") and area.mask != mask and can_see == true:
		objective = area.position
		times_played = 0
		$AnimationPlayer.stop(true)
		allow_movement = true

func _movement_axis():
	var AB = Vector2(position.x + cos(rotation), position.y) - position
	var BC = Vector2(position.x + cos(rotation), position.y + sin(rotation)) - Vector2(position.x + cos(rotation), position.y)
	var W = AB + BC
	return [W, Vector2(-W.y, W.x)]


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	allow_movement = true

	
func _on_lantern_area_exited(area: Area2D) -> void:
	if area.is_in_group("objectives") and area.mask != mask:
		print(area.mask)
		forget.start()

func _on_periferal_vision_area_entered(area: Area2D) -> void:
	if area.is_in_group("objectives") and forget.time_left < 0.2 and area.mask != mask:
		objective = area.position
		$AnimationPlayer.stop()
		allow_movement = true

func follow_path():
	times_played = 0
	objective = route[i]
	i += 1
	if i >= len(route):
		i = 0


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	times_played += 1
