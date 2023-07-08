extends Control

@export var main_game_scene: PackedScene


func _on_start_button_pressed():
	get_tree().change_scene_to_packed(main_game_scene)


func _on_quit_button_pressed():
	get_tree().quit()
