extends Control


var SettingsMenu: PackedScene = preload("res://scenes/GUI/settings.tscn")

@export var main_game_scene: PackedScene


func _on_start_button_pressed():
	get_tree().change_scene_to_packed(main_game_scene)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_buttion_pressed() -> void:
	var settings: Node = SettingsMenu.instantiate()
	add_child(settings)
