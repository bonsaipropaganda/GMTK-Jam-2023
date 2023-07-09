extends Node


signal player_caught()


@export var PassingShadowWarning: PackedScene
# controls the speed of the shadow scene passing by
@export var shadow_speed: float
@export var new_shadow_timer: int

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if new_shadow_timer > 0.0:
		$NewShadow.wait_time = new_shadow_timer
		$NewShadow.start()


func _on_new_shadow_timeout():
	if PassingShadowWarning:
		var new_PassingShadowWarning = PassingShadowWarning.instantiate()
			
		match rng.randi_range(0,1):
			0:
				new_PassingShadowWarning.walk_direction = "right"
			1:
				new_PassingShadowWarning.walk_direction = "left"
		
		new_PassingShadowWarning.shadow_speed = shadow_speed
		add_child(new_PassingShadowWarning) 


