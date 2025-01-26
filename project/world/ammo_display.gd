class_name AmmoDisplay
extends Control


@onready var _ammo_bar : TextureProgressBar = %AmmoBar

func set_color(color : Color):
	_ammo_bar.modulate = color

func decrease(value : int):
	_ammo_bar.value -= value

func refill(element : Element):
	_ammo_bar.value = 50
	set_color(element.color)
