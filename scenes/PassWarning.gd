extends Node2D


var walk_direction: String = "right"

@export var warning_length: float = 3.0
@export var blink_rate: float = 5.0

@onready var tween_rate: float = warning_length/(blink_rate * 2)

@export var PassingShadow: PackedScene
var rng = RandomNumberGenerator.new()

var shadow_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	if(walk_direction == "right"):
		position = Vector2(64,96)
	else:
		position = Vector2(480,96)
	
	$CreateShadowTimer.set_wait_time(warning_length)
	$CreateShadowTimer.start()
	set_modulate(Color(1,1,1,0))
	
	var tween = create_tween()
	tween.set_loops(int(blink_rate))
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1) , tween_rate) #Fade In
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0) , tween_rate) #Fade Out


func _on_create_shadow_timer_timeout():
	var new_PassingShadow = PassingShadow.instantiate()
	new_PassingShadow.player_caught.connect(get_parent().emit_signal.bind(&"player_caught"), CONNECT_ONE_SHOT)

	new_PassingShadow.walk_direction = walk_direction
	
	new_PassingShadow.shadow_speed = shadow_speed
	get_parent().add_child(new_PassingShadow) 
	
	queue_free()
