extends CharacterBody2D


@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@export var target_to_chase: CharacterBody2D

const walk_speed = 400
var enemy_health = 4

func _physics_process(delta: float) -> void:
	navigation_agent.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position())* walk_speed
	move_and_slide()
