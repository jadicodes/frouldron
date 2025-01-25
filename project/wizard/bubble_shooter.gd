extends Node2D

var bubble_type
var _bubble: Bubble


func set_bubble_type():
	pass


func get_bubble_type():
	pass


func shoot():
	pass


func make_new_bubble():
	_bubble = preload("res://wizard/bubble/bubble.tscn").instantiate()
	call_deferred("add_child", _bubble)
