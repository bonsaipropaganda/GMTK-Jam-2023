extends CanvasLayer


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
