class_name Boss
extends CharacterBody2D

const ELEMENTS: Array[Element] = [
	preload("res://element/normal.tres"),
	preload("res://element/electricity.tres"),
	preload("res://element/earth.tres")
]

var health := 20

@onready var _attack_origin := %AttackOrigin
@onready var _animation_tree: AnimationTree = %AnimationTree
@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	get_tree().create_timer(5).timeout.connect(_step)

func hit(element: Element) -> void:
	health -= element.damage

	_animation_player.play("hit")

	if health <= 0:
		queue_free()

func _reset_vars() -> void:
	_animation_tree["parameters/conditions/attack_left"] = false
	_animation_tree["parameters/conditions/attack_right"] = false


func _step() -> void:
	if randf() > 0.5:
		_animation_tree["parameters/conditions/attack_left"] = true
	else:
		_animation_tree["parameters/conditions/attack_right"] = true

	get_tree().create_timer(randf_range(1, 3)).timeout.connect(_step)


func _attack(direction: int) -> void:
	var element = ELEMENTS.pick_random()

	var bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	bubble.collision_mask = 3
	get_tree().get_root().add_child(bubble)
	bubble.global_position = _attack_origin.global_position
	bubble.set_velocity(velocity + Vector2.RIGHT * direction * 500 * element.force)
	bubble.set_element(element)
