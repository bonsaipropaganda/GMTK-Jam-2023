extends Label

@export var time_left := 30

signal level_passed()


func _ready() -> void:
	text = "Time left: " + str(time_left) + " s"


func _on_level_timer_timeout():
	time_left -= 1 # TOFIX: the first time it does not decrease (but it does execute)
	text = "Time left: " + str(time_left) + " s"
	$LevelTimer.start()
	
	if time_left <= 0:
		$LevelTimer.stop()
		level_passed.emit()
