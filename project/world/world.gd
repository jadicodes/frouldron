extends Node2D

@onready var _ammo_bar : TextureProgressBar = %AmmoBar
@onready var _bubble_shooter : BubbleShooter = $Wizard/BubbleShooter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ammo_bar.modulate = _bubble_shooter.element.color


func _on_wizard_ammo_used(decrease_amt : int) -> void:
	print(decrease_amt)
	_ammo_bar.value -= decrease_amt


func _on_cauldron_add_ammo() -> void:
	_bubble_shooter.fill_ammo()
	_ammo_bar.value = _bubble_shooter.MAX_AMMO


func _on_cauldron_change_element(element: Element) -> void:
	_bubble_shooter.set_bubble_type(element)
	_ammo_bar.modulate = element.color
