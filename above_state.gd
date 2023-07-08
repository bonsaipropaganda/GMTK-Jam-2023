extends PlayerState


	
func _physics_process(delta: float) -> void:
	$"../..".burrowed = false;
	
	if Input.is_action_just_pressed("key_down") and $"../..".is_on_floor():
		$"../../AnimatedSprite2D".animation = "burrowed" 
		get_parent().switch_to_state("below_state")
