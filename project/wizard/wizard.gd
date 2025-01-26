class_name Wizard
extends CharacterBody2D

signal ammo_used(decrease_amt : int)


const _SPEED := 250.0
const _JUMP_VELOCITY := -700.0
const _DAMAGE := 12
const _MAX_HEALTH := 100

static var instance: Wizard

var _health := _MAX_HEALTH
var _current_direction := -1
var _double_jump = 0


@onready var _bubble_shooter : BubbleShooter = $BubbleShooter
@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _health_bar: TextureProgressBar = $WizardHealth

func _ready() -> void:
	instance = self
	_health_bar.value = _health


func _physics_process(delta: float) -> void:
	_animation_tree["parameters/conditions/shoot_pressed"] = false
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		_double_jump = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and _double_jump != 2:
		velocity.y = _JUMP_VELOCITY
		_double_jump += 1

	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		_current_direction = 1 if direction > 0 else -1
		scale.y = -_current_direction
		rotation = PI if direction > 0 else 0.0
		_health_bar.fill_mode =  1 if direction > 0 else 0
		velocity.x = direction * _SPEED
		_animation_tree["parameters/conditions/idle"] = false
		_animation_tree["parameters/conditions/is_moving"] = true
	else:
		_animation_tree["parameters/conditions/idle"] = true
		_animation_tree["parameters/conditions/is_moving"] = false
		velocity.x = move_toward(velocity.x, 0, _SPEED)

	if Input.is_action_just_pressed("shoot"):
		var shot := _bubble_shooter.shoot(velocity, _current_direction)
		_animation_tree["parameters/conditions/shoot_pressed"] = shot

		if shot:
			_health = clamp(_health + _bubble_shooter.element.heal, 0, _MAX_HEALTH)
			_health_bar.value = _health

	move_and_slide()


#func _on_hitbox_area_entered(area: Area2D) -> void:
	#if(area.get_parent() is BaseEnemy):
		#_health -= _DAMAGE
		#_health_bar.value = _health
		#if(_health <= 0):
			#$DeathSound.play()
		#else:
			#$HurtSound.pitch_scale = randf_range(0.95, 1.05)
			#$HurtSound.play()

func hit(damage:int ) -> void:
	_health -= _DAMAGE
	_health_bar.value = _health
	if(_health <= 0):
		$DeathSound.play()
	else:
		$HurtSound.pitch_scale = randf_range(0.95, 1.05)
		$HurtSound.play()

func _on_bubble_shooter_ammo_used(decrease_amt) -> void:
	# Pass to world
	ammo_used.emit(decrease_amt)
