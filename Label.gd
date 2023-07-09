extends Label

@export var time_left:= 60
signal level_passed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Time left: " + str(time_left)
	
	if time_left <= 0:
		$LevelTimer.stop()
		level_passed.emit()


func _on_level_timer_timeout():
	time_left -= 1
	$LevelTimer.start()
