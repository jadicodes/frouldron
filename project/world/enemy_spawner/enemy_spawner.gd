extends Marker2D
var enemy = [
	preload("res://enemy/base_enemy.tscn"),
	preload("res://enemy/knight_enemy.tscn")
	] 

var base_enemy: BaseEnemy
var _can_spawn := false


func make_base_enemy():
	base_enemy = enemy.pick_random().instantiate()
	get_parent().add_child(base_enemy)
	base_enemy.global_position = global_position

func turn_on_spawning():
	$Timer.start()

func turn_off_spawning():
	$Timer.stop()

func _on_on_screen_notifier_screen_exited() -> void:
	_can_spawn = true


func _on_on_screen_notifier_screen_entered() -> void:
	_can_spawn = false


func _on_timer_timeout() -> void:
	make_base_enemy()
