class_name BubbleShooter
extends Node2D

signal ammo_used(decrease_amt: int)

const MAX_AMMO := 50.0

@export var element: Element = preload("res://element/normal.tres")

var _bubble: Bubble
var _current_ammo := MAX_AMMO

@onready var _bubble_point := %BubblePoint


func set_bubble_type(new_element: Element)-> void:
	element = new_element


func fill_ammo():
	_current_ammo = MAX_AMMO


func get_bubble_type():
	pass


func shoot(direction : Vector2) -> void:
	if(_current_ammo > 0):
		_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
		get_tree().get_root().add_child(_bubble)
		_bubble.global_position = _bubble_point.global_position
		_bubble.set_velocity(direction)
		_bubble.set_element(element)
		_current_ammo -= _bubble.element.ammo_usage
		var decrease :  = _bubble.element.ammo_usage
		ammo_used.emit(decrease)
		$BubbleSound.play()
	
