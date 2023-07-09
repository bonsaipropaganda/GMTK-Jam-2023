extends Label

@export var total_time:= 30
var time_left = total_time
signal level_passed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_timer_timeout():
	self.text = "Time left: " + str(time_left)
	time_left -= 1
	$LevelTimer.start()
	
	if time_left <= 0:
		reset()
		level_passed.emit()
		$LevelTimer.start()

func reset():
	time_left = total_time
	$LevelTimer.stop()
