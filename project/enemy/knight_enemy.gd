extends CharacterBody2D

const WALK_SPEED = 100
signal damage(dealt:int)
@onready var _animation_tree: AnimationTree = %AnimationTree
@export var health = 4
var _current_direction := 1
var _direction := 1
var element: Element = [
	preload("res://element/normal.tres"),
	preload("res://element/earth.tres")
].pick_random()


func _ready() -> void:
	_animation_tree["parameters/conditions/is_attacking"] = false
	pass


func _physics_process(delta: float) -> void:
	_move(delta)


func _move(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if %RayCast.is_colliding():
		_current_direction = 1 if _direction > 0 else -1
		scale.y = -_current_direction
		rotation = PI if _direction > 0 else 0.0
		_direction = _direction * -1
		#%RayCast.rotate(deg_to_rad(180))

	if _direction:
		velocity.x = _direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)


	move_and_slide()


func hit(bubble_element: Element) -> void:
	health -= bubble_element.damage

	if health <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	_animation_tree["parameters/conditions/is_attacking"] = true
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	_animation_tree["parameters/conditions/is_attacking"] = false

func deal_damage():
	if _animation_tree["parameters/conditions/is_attacking"] == true:
		Wizard.instance.hit(12)
		
