extends Node2D


func _input(event):
	if event.is_action_pressed("ui_end"):
		get_tree().quit()
