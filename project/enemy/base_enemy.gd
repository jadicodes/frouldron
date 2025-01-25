extends CharacterBody2D



const walk_speed = 400
var enemy_health = 4

func _physics_process(delta: float) -> void:
	move_and_slide()
