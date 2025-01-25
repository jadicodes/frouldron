extends Camera2D

@export var target: Node2D


func _ready() -> void:
	global_position.x = target.global_position.x

func _process(_delta: float) -> void:
	if not target:
		return

	global_position.x = target.global_position.x + clampf(global_position.x - target.global_position.x, -256, 256)
