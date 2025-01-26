extends Node2D

@onready var _ammo_display : AmmoDisplay = $AmmoDisplay
@onready var _bubble_shooter : BubbleShooter = $Wizard/BubbleShooter


func _ready() -> void:
	_ammo_display.refill(_bubble_shooter.element)


func _on_wizard_ammo_used(decrease_amt: int) -> void:
	_ammo_display.decrease(decrease_amt)


func _on_cauldron_add_ammo() -> void:
	_bubble_shooter.fill_ammo()
	_ammo_display.refill(_bubble_shooter.element)


func _on_cauldron_change_element(element: Element) -> void:
	_bubble_shooter.set_bubble_type(element)
	_ammo_display.refill(element)
