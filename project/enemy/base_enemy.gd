extends CharacterBody2D

const walk_speed = 400

@export var enemy_health = 4

var element: Element = [
	preload("res://element/normal.tres"),
	preload("res://element/earth.tres")
].pick_random()

@onready var sprite: Sprite2D = %Sprite2D

func _ready() -> void:
	sprite.modulate = element.color

func _physics_process(delta: float) -> void:
	move_and_slide()
