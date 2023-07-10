extends Control


const SettingsMenu: PackedScene = preload("res://scenes/GUI/settings.tscn")

@export var main_game_scene: PackedScene


func _on_start_button_pressed():
	start_game(1)


func start_game(level_index: int) -> void:
	var main_game: Node2D = main_game_scene.instantiate()
	main_game.ready.connect(main_game.load_level.bind(level_index), CONNECT_ONE_SHOT)
	get_tree().get_root().add_child(main_game)
	get_tree().set_current_scene(main_game)
	queue_free()


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_buttion_pressed() -> void:
	var settings: Node = SettingsMenu.instantiate()
	add_child(settings)

func _input(event):
	if event.is_action_pressed("l_click"):
		$Click.play()
