extends Node2D

var bubble_type
var _bubble: Bubble


func set_bubble_type():
	pass


func get_bubble_type():
	pass


func shoot(wizard_position, direction):
	_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	get_tree().get_root().add_child(_bubble)
	_bubble.global_position = wizard_position
	_bubble.set_vel(direction)
