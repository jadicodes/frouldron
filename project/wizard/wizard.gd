extends CharacterBody2D


const _SPEED := 200.0
const _JUMP_VELOCITY := -400.0

var _health := 100


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY


	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
