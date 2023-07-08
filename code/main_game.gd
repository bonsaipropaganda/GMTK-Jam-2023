extends Node2D


const PauseMenu: PackedScene = preload("res://scenes/GUI/pause_menu.tscn")


func _input(event):
	if event.is_action_pressed("pause"):
		var pause: Node = PauseMenu.instantiate()
		add_child(pause)
