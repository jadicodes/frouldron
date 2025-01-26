extends Control

func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_open_tutorial_button_pressed() -> void:
	$TutorialScreen.visible = true
	$TutorialText.visible = true
	$CloseTutorialButton.visible = true


func _on_close_tutorial_button_pressed() -> void:
	$TutorialScreen.visible = false
	$TutorialText.visible = false
	$CloseTutorialButton.visible = false


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/credits.tscn")
