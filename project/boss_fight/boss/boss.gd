class_name Boss
extends CharacterBody2D

signal died

const ELEMENTS: Array[Element] = [
	preload("res://element/normal.tres"),
	preload("res://element/electricity.tres"),
	preload("res://element/earth.tres")
]

@export var _target: Node2D
@export var _follow_distance := 512
@export var _speed := 256.0

var health := 20

@onready var _attack_origin := %AttackOrigin
@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	get_tree().create_timer(5).timeout.connect(_attack_step)


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO

	if global_position.distance_to(_target.global_position) > _follow_distance:
		velocity = (_target.global_position - global_position).normalized() * _speed

	move_and_slide()

func hit(element: Element) -> void:
	health -= element.damage

	_animation_player.play("hit")

	if health <= 0:
		died.emit()
		queue_free()

func _reset_vars() -> void:
	_animation_tree["parameters/conditions/attack_left"] = false
	_animation_tree["parameters/conditions/attack_right"] = false


func _attack_step() -> void:
	if (_target.global_position - global_position).x < 0:
		_animation_tree["parameters/conditions/attack_left"] = true
	else:
		_animation_tree["parameters/conditions/attack_right"] = true

	get_tree().create_timer(randf_range(1, 3)).timeout.connect(_attack_step)


func _attack(direction: int) -> void:
	var element = ELEMENTS.pick_random()

	var bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	bubble.collision_mask = 3
	get_parent().add_child(bubble)
	bubble.global_position = _attack_origin.global_position
	bubble.set_velocity(velocity + Vector2.RIGHT * direction * 500 * element.force)
	bubble.set_element(element)
