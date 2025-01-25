extends CharacterBody2D

signal ammo_used(decrease_amt : int)

const _SPEED := 200.0
const _JUMP_VELOCITY := -400.0
const _DAMAGE := 12

var _health := 100


@onready var _shoot_marker := %ShootMarker
@onready var _bubble_shooter : BubbleShooter = $BubbleShooter
@onready var _animation_tree: AnimationTree = %AnimationTree


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY
	
	if Input.is_action_just_pressed("shoot"):
		_bubble_shooter.shoot(velocity)

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * _SPEED
		_animation_tree["parameters/conditions/idle"] = false
		_animation_tree["parameters/conditions/is_moving"] = true
	else:
		_animation_tree["parameters/conditions/idle"] = true
		_animation_tree["parameters/conditions/is_moving"] = false
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if(area.get_parent() is BaseEnemy): 
		_health -= _DAMAGE
		print(_health)


func _on_bubble_shooter_ammo_used(decrease_amt) -> void:
	# Pass to world
	ammo_used.emit(decrease_amt)
