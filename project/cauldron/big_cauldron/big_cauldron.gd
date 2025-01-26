extends Area2D

@export var _bubble_types : Array[Element]


func _ready():
	var counter = 0
	for children in $Gems.get_children():
		children.modulate = Color(_bubble_types[counter].color.r, _bubble_types[counter].color.g, _bubble_types[counter].color.b, .5)
		counter += 1


func _on_body_entered(body: Node2D) -> void:
	if body is Bubble:
		pass
