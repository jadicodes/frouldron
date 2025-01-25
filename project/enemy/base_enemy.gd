class_name BaseEnemy
extends CharacterBody2D

const WALK_SPEED = 200

@export var health = 4

var _direction := 1
var element: Element = [
	preload("res://element/normal.tres"),
	preload("res://element/earth.tres")
].pick_random()

@onready var sprite: Sprite2D = %Sprite


func _ready() -> void:
	sprite.modulate = element.color


func _physics_process(delta: float) -> void:
	_move(delta)


func _move(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if %RayCast.is_colliding():
		_direction = _direction * -1
		%RayCast.rotate(deg_to_rad(180))

	if _direction:
		velocity.x = _direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)


	move_and_slide()


func hit(bubble_element: Element) -> void:
	health -= bubble_element.damage

	if health <= 0:
		queue_free()
