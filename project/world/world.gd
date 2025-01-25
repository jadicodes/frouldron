extends Node2D

@onready var _ammo_bar : TextureProgressBar = %AmmoBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wizard_ammo_used(decrease_amt) -> void:
	print(decrease_amt)
	_ammo_bar.value -= decrease_amt
	


func _on_cauldron_add_ammo() -> void:
	$Wizard/BubbleShooter.fill_ammo()
	_ammo_bar.value = $Wizard/BubbleShooter.MAX_AMMO


func _on_cauldron_change_element(element: Element) -> void:
	$Wizard/BubbleShooter.set_bubble_type(element)
