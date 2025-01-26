extends Area2D

signal change_element(element:Element)
signal add_ammo()

var interact := false
@export var element : Element = preload("res://element/normal.tres")

func _ready() -> void:
	$Cauldron/CauldronContents.modulate = element.color


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and interact == true:
		add_ammo.emit()
		change_element.emit(element)


func _on_body_entered(_body: Node2D) -> void:
	interact = true
	

func _on_body_exited(_body: Node2D) -> void:
	interact = false
