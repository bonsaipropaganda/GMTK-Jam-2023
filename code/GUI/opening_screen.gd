extends Node2D




func _on_ok_pressed() -> void:
	get_parent().get_parent().load_level(2)
