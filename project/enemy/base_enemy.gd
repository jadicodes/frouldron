class_name BaseEnemy
extends CharacterBody2D

const WALK_SPEED = 400

@export var health = 4

var element: Element = [
	preload("res://element/normal.tres"),
	preload("res://element/earth.tres")
].pick_random()

@onready var sprite: Sprite2D = %Sprite2D

func _ready() -> void:
	sprite.modulate = element.color

func _physics_process(delta: float) -> void:
	_move(delta)

func _move(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := 1
	if direction:
		velocity.x = direction * WALK_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, WALK_SPEED)

	move_and_slide()

func hit(bubble_element: Element) -> void:
	health -= bubble_element.damage

	if health <= 0:
		queue_free()
