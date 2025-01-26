extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene_to_file("res://menus/title_screen.tscn")
	if Input.is_action_just_pressed("shoot"):
		get_tree().quit()


func _on_title_screen_pressed() -> void:
	get_tree().change_scene_to_file("res://menus/title_screen.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
