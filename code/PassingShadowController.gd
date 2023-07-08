extends Node

@export var PassingShadowWarning: PackedScene
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_new_shadow_timeout():
	var new_PassingShadowWarning = PassingShadowWarning.instantiate()
		
	match rng.randi_range(0,1):
		0:
			new_PassingShadowWarning.walk_direction = "right"
		1:
			new_PassingShadowWarning.walk_direction = "left"
		
	add_child(new_PassingShadowWarning) 


