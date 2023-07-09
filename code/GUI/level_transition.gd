extends CanvasLayer


signal next_level_button_pressed()
signal retry_button_pressed()


func _ready() -> void:
	get_tree().paused = true


func _exit_tree() -> void:
	get_tree().paused = false


func _on_next_level_pressed() -> void:
	next_level_button_pressed.emit()
	queue_free()


func _on_retry_pressed() -> void:
	retry_button_pressed.emit()
	queue_free()
