extends Marker2D

var base_enemy: BaseEnemy
var _can_spawn := false


func make_base_enemy(new_enemy):
	base_enemy = preload("res://enemy/base_enemy.tscn").instantiate()
	get_tree().get_root().add_child(base_enemy)


func _on_on_screen_notifier_screen_exited() -> void:
	_can_spawn = true


func _on_on_screen_notifier_screen_entered() -> void:
	_can_spawn = false
