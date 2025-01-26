extends Area2D

@export var _bubble_types : Array[Element]

var boss_condition := 0

# Take all of the elements and match them with a Gem Sprite so that each element is represented by a gem.
func _ready():
	var counter = 0
	for children in $Gems.get_children():
		children.modulate = Color(_bubble_types[counter].color.r, _bubble_types[counter].color.g, _bubble_types[counter].color.b, .2)
		counter += 1


func _on_body_entered(body: Node2D) -> void:
	if body is Bubble:
		var element = body.element
		# For children of Gems (these children should all be the modulated bubble sprites)
		var gem_index := _bubble_types.find(element)
		var gem := $Gems.get_child(gem_index)

		if gem.modulate.a == 1:
			return

		gem.modulate = Color(element.color.r, element.color.g, element.color.b, 1)
		body.queue_free()

		boss_condition += 1

		if boss_condition == _bubble_types.size():
			_trigger_boss()


func _trigger_boss():
	print("BOSS TIME! WAH!!")
