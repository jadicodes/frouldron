class_name BubbleShooter
extends Node2D

var bubble_type
var _bubble: Bubble


func set_bubble_type():
	pass


func get_bubble_type():
	pass


func shoot(direction : Vector2) -> void:
	_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	get_tree().get_root().add_child(_bubble)
	_bubble.global_position = self.global_position
	_bubble.set_vel(direction)
