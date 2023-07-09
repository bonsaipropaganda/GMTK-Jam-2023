extends CanvasLayer

signal try_again_button_pressed()


func _on_try_again_pressed() -> void:
	try_again_button_pressed.emit()
	queue_free()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
