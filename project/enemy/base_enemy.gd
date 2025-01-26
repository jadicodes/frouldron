class_name BaseEnemy
extends CharacterBody2D


const WALK_SPEED = 100

var _current_direction := 1
var _direction := 1
<<<<<<< HEAD
var element: Element = preload("res://element/normal.tres")
=======
var element: Element = [
	preload("res://element/normal.tres"),
	preload("res://element/earth.tres")
].pick_random()
var _corpse := preload("res://enemy/enemy_corpse.tscn")

@onready var _animation_tree: AnimationTree = %AnimationTree
@export var health = 4
>>>>>>> 4df644f (Spawn a gunk pile when enemy dies)


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

	if _direction:
		velocity.x = _direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()


func hit(bubble_element: Element) -> void:
	health -= bubble_element.damage

	if health <= 0:
		var dead_pile = _corpse.instantiate()
		var dead_y = global_position.y - 50
		dead_pile.global_position = Vector2(global_position.x, dead_y)
		get_parent().add_child(dead_pile)
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	_animation_tree["parameters/conditions/is_attacking"] = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	_animation_tree["parameters/conditions/is_attacking"] = false


func deal_damage():
	if _animation_tree["parameters/conditions/is_attacking"] == true:
		Wizard.instance.hit(element)
