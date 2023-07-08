extends CanvasLayer

const SettingsMenu: PackedScene = preload("res://scenes/GUI/settings.tscn")


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _on_continue_pressed() -> void:
	queue_free()


func _on_settings_pressed() -> void:
	var settings: Node = SettingsMenu.instantiate()
	get_parent().add_child(settings)


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
