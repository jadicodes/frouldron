extends Area2D

signal change_element(element:Element)
signal add_ammo()

var interact := false
@export var element = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if element == 0:
		$Water.visible = true
	if element == 1:
		$Fire.visible = true
	if element == 2:
		$Acid.visible = true
	if element == 3:
		$Earth.visible = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and interact == true:
		if element == 0:
			emit_signal("add_ammo")
			emit_signal("change_element","normal.tres")
		if element == 1:
			emit_signal("add_ammo")
			emit_signal("change_element", "Fire.tres")
		if element == 2:
			emit_signal("add_ammo")
			emit_signal("change_element","Acid.tres")
		if element == 3:
			emit_signal("add_ammo")
			emit_signal("change_element", preload("res://element/earth.tres"))
	

func _on_body_entered(body: Node2D) -> void:
	interact = true
	

func _on_body_exited(body: Node2D) -> void:
	interact = false
