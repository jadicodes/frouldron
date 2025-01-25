class_name Bubble
extends CharacterBody2D

@export var element: Element = preload("res://element/normal.tres")

var _velocity: Vector2 = Vector2.ZERO
var _num_hits: int = 0

@onready var sprite: Sprite2D = %Sprite2D


func _ready() -> void:
	assert(element, "Element not set for bubble")

	sprite.modulate = element.color

func set_vel(new_velocity: Vector2) -> void:
	_velocity = new_velocity

func _physics_process(delta: float) -> void:
	_velocity += get_gravity() * element.gravity_scale * delta

	var collision = move_and_collide(_velocity * delta)

	if collision:
		_collide(collision)

func _collide(_collision: KinematicCollision2D) -> void:
	_velocity = _velocity.reflect(_collision.get_normal()) # TODO: Figure out why reflections don't work
	_num_hits += 1

	if _num_hits > element.bounces:
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()