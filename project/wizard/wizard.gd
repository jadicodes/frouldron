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
var _can_double_jump = true
var _can_move = false


@onready var _bubble_shooter : BubbleShooter = $BubbleShooter
@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _health_bar: TextureProgressBar = $WizardHealth
@onready var _jump_bubbles: Marker2D = %JumpBubbles

func _ready() -> void:
	instance = self
	_health_bar.value = _health


func _physics_process(delta: float) -> void:
	if _can_move:
		_animation_tree["parameters/conditions/shoot_pressed"] = false
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		if not _can_move:
			move_and_slide()
			return

		if is_on_floor() and _can_double_jump:
			_double_jump = 0

		# Handle jump.
		if Input.is_action_just_pressed("jump") and _double_jump < 2:
			if not _double_jump == 1 or _bubble_shooter._current_ammo > 0:
				velocity.y = _JUMP_VELOCITY
			if _double_jump == 1:
				_spawn_jump_bubbles()
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


func hit(element: Element) -> void:
	_health -= element.damage * _DAMAGE
	_health_bar.value = _health
	if(_health <= 0):
		$DeathSound.play()
	else:
		$HurtSound.pitch_scale = randf_range(0.95, 1.05)
		$HurtSound.play()


func _on_bubble_shooter_ammo_used(decrease_amt) -> void:
	# Pass to world
	ammo_used.emit(decrease_amt)


func _spawn_jump_bubbles():
	if _bubble_shooter._current_ammo <= 0:
		return

	var element := _bubble_shooter.element
	for i in range(-1, 2):
		var bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
		get_tree().get_root().add_child(bubble)
		bubble.set_element(element)
		bubble.global_position = _jump_bubbles.global_position
		bubble.set_velocity(Vector2.DOWN.rotated(deg_to_rad(15 * i)) * 500 * element.force)
	_bubble_shooter._current_ammo -= element.ammo_usage * 2
	_on_bubble_shooter_ammo_used(element.ammo_usage * 2)


func _on_bubble_shooter_ammo_gone() -> void:
	_can_double_jump = false
	print("cannot double jump")


func _on_bubble_shooter_ammo_refilled() -> void:
	_can_double_jump = true
	print("can double jump")


func set_can_move(if_can_move):
	_can_move = if_can_move
