extends Camera2D

@export var target: Node2D
var _boss_condition_met = false


func _ready() -> void:
	global_position.x = target.global_position.x


func _process(_delta: float) -> void:
	if not target:
		return

	global_position.x = target.global_position.x + clampf(global_position.x - target.global_position.x, -256, 256)


func change_target(new_target):
	target = new_target
