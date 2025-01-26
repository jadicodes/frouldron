class_name Bubble
extends CharacterBody2D

@export var element: Element = preload("res://element/normal.tres")

var _num_hits: int = 0
var _enabled := true

@onready var sprite: Sprite2D = %Sprite2D
@onready var timer: Timer = %Timer
@onready var _spawn_sound: AudioStreamPlayer2D = %SpawnSound
@onready var _bounce_sound: AudioStreamPlayer2D = %BounceSound
@onready var _impact_sound: AudioStreamPlayer2D = %ImpactSound


func _ready() -> void:
	assert(element, "Element not set for bubble")

	set_element(element)
	_play_sound(_spawn_sound)


func _physics_process(delta: float) -> void:
	if not _enabled:
		return

	velocity += get_gravity() * element.gravity_scale * delta

	var collision = move_and_collide(velocity * delta)

	if collision:
		_collide(collision)


func _collide(collision: KinematicCollision2D) -> void:
	if not _enabled:
		return

	var collider = collision.get_collider()

	if collider.has_method("hit"):
		collider.hit(element)
		pop()
		return

	velocity = velocity.bounce(collision.get_normal())
	_num_hits += 1

	if _num_hits > element.bounces:
		pop()
	else:
		_play_sound(_bounce_sound)


func _on_timer_timeout() -> void:
	if not _enabled:
		return

	pop()


func pop() -> void:
	_play_sound(_impact_sound)
	_enabled = false
	visible = false
	_impact_sound.finished.connect(queue_free)


func _play_sound(player: AudioStreamPlayer2D) -> void:
	player.pitch_scale = randf_range(0.9, 1.1)
	player.play()


func set_element(new_element: Element) -> void:
	element = new_element
	sprite.modulate = element.color
	timer.stop()
	timer.start(element.lifetime)
	_bounce_sound.stream = element.bounce_sound
	_impact_sound.stream = element.impact_sound


func _bubble_direction():
	pass
