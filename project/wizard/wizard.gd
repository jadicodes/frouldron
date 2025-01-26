extends CharacterBody2D

signal ammo_used(decrease_amt : int)

const _SPEED := 200.0
const _JUMP_VELOCITY := -400.0
const _DAMAGE := 12

var _health := 100
var _current_direction := -1


@onready var _bubble_shooter : BubbleShooter = $BubbleShooter
@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _health_bar: TextureProgressBar = $WizardHealth

func _ready() -> void:
	_health_bar.value = _health


func _physics_process(delta: float) -> void:
	_animation_tree["parameters/conditions/shoot_pressed"] = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		_current_direction = 1 if direction > 0 else -1
		scale.y = -_current_direction
		rotation = PI if direction > 0 else 0.0
		velocity.x = direction * _SPEED
		_animation_tree["parameters/conditions/idle"] = false
		_animation_tree["parameters/conditions/is_moving"] = true
	else:
		_animation_tree["parameters/conditions/idle"] = true
		_animation_tree["parameters/conditions/is_moving"] = false
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	if Input.is_action_just_pressed("shoot"):
		_animation_tree["parameters/conditions/shoot_pressed"] = _bubble_shooter.shoot(velocity, _current_direction)

	move_and_slide()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if(area.get_parent() is BaseEnemy): 
		_health -= _DAMAGE
		_health_bar.value = _health
		if(_health <= 0):
			$DeathSound.play()
		else:
			$HurtSound.play()


func _on_bubble_shooter_ammo_used(decrease_amt) -> void:
	# Pass to world
	ammo_used.emit(decrease_amt)
