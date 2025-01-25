class_name Bubble
extends CharacterBody2D

@export var element: Element = preload("res://element/normal.tres")

var _num_hits: int = 0

@onready var sprite: Sprite2D = %Sprite2D


func _ready() -> void:
	assert(element, "Element not set for bubble")

	sprite.modulate = element.color

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * element.gravity_scale * delta

	var collision = move_and_collide(velocity * delta)

	if collision:
		_collide(collision)

func _collide(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()

	if collider.has_method("hit"):
		collider.hit(element)
		queue_free()

	velocity = velocity.bounce(collision.get_normal())
	_num_hits += 1

	if _num_hits > element.bounces:
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()

func set_element(new_element: Element) -> void:
	element = new_element
	sprite.modulate = element.color
