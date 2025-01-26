class_name BubbleShooter
extends Node2D

signal ammo_used(decrease_amt: int)
signal ammo_gone
signal ammo_refilled

const MAX_AMMO := 50.0

@export var element: Element = preload("res://element/normal.tres")

var _bubble: Bubble
var _current_ammo := MAX_AMMO

@onready var _bubble_point := %BubblePoint


func set_bubble_type(new_element: Element)-> void:
	element = new_element


func fill_ammo():
	_current_ammo = MAX_AMMO
	ammo_refilled.emit()


func get_bubble_type():
	pass


func shoot(velocity: Vector2, direction: float) -> bool:
	if not has_ammo():
		ammo_gone.emit()
		return false

	_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	get_parent().get_parent().add_child(_bubble)
	_bubble.global_position = _bubble_point.global_position
	_bubble.set_velocity(velocity + Vector2.RIGHT * direction * 500 * element.force)
	_bubble.set_element(element)
	_current_ammo -= _bubble.element.ammo_usage
	var decrease :  = _bubble.element.ammo_usage
	ammo_used.emit(decrease)

	return true
	
func has_ammo() -> bool:
	return _current_ammo > 0
