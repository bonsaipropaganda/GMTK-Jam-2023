extends Node2D


func _process(_delta: float) -> void:
	$IAmAPlayer.position = get_global_mouse_position()
