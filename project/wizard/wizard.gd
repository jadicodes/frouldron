extends CharacterBody2D

signal ammo_used

const _SPEED := 200.0
const _JUMP_VELOCITY := -400.0

var _health := 100


@onready var _shoot_marker := %ShootMarker
@onready var _bubble_shooter : BubbleShooter = $BubbleShooter


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
	
	if Input.is_action_just_pressed("shoot"):
		_bubble_shooter.shoot(velocity)

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_bubble_shooter_ammo_used() -> void:
	# Pass to world
	ammo_used.emit()
