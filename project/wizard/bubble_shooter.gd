class_name BubbleShooter
extends Node2D

const _MAX_AMMO := 50

var bubble_type
var _bubble: Bubble
var _current_ammo := _MAX_AMMO

signal ammo_used 


func set_bubble_type():
	pass


func get_bubble_type():
	pass


func shoot(direction : Vector2) -> void:
	if(_current_ammo > 0):
		_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
		get_tree().get_root().add_child(_bubble)
		_bubble.global_position = self.global_position
		_bubble.set_vel(direction)
		_current_ammo -= _bubble.element.ammo_usage
		ammo_used.emit()
	
