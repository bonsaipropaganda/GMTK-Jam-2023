extends Node2D


func _process(_delta: float) -> void:
	$IAmAPlayer.position = get_global_mouse_position()
	
	if Input.is_action_just_pressed("fullscreen"):
		if(DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
