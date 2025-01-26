extends Node2D

var _text_index = 0
@onready var _ammo_bar : TextureProgressBar = %AmmoBar
@onready var _bubble_shooter : BubbleShooter = $Wizard/BubbleShooter
@export var _opening_scene_text : Array[String]
@export var _boss_transition_text : Array[String]
var _current_text_sequence: Array[String]
var _boss_time = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_ammo_bar.modulate = _bubble_shooter.element.color
	_current_text_sequence = _opening_scene_text
	_play_opening_cutscene()
	


func _play_opening_cutscene():
	$AnimationPlayer.play("opening")


func _on_wizard_ammo_used(decrease_amt : int) -> void:
	_ammo_bar.value -= decrease_amt


func _on_cauldron_add_ammo() -> void:
	_bubble_shooter.fill_ammo()
	_ammo_bar.value = _bubble_shooter.MAX_AMMO


func _on_cauldron_change_element(element: Element) -> void:
	_bubble_shooter.set_bubble_type(element)
	_ammo_bar.modulate = element.color


func _on_textbox_finished_current_text() -> void:
	_text_index += 1
	%Textbox.set_text(_current_text_sequence[_text_index])


func _on_textbox_finished_all_text() -> void:
	%Textbox.hide()
	%Wizard.set_can_move(true)
	_text_index = 0
	if _boss_time == true:
		$AnimationPlayer.play("fade_to_white")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "opening":
		%Textbox.show()
		%Textbox.set_queue(_current_text_sequence.size())
		%Textbox.set_text(_current_text_sequence[_text_index])
	if anim_name == "transition_to_boss":
		$BigCauldron.play_animation()
	if anim_name == "fade_to_white":
		get_tree().change_scene_to_file("res://boss_fight/boss_fight.tscn")


func _on_big_cauldron_boss_condition_met() -> void:
	$Camera2D.change_target($BigCauldron)
	$AnimationPlayer.play("transition_to_boss")
	_current_text_sequence = _boss_transition_text
	%Textbox.set_queue(_current_text_sequence.size())
	%Textbox.set_text(_current_text_sequence[_text_index])
	%Wizard.set_can_move(false)
	%Textbox.show()
	_boss_time = true
	
