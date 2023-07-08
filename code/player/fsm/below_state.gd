extends PlayerState

func _physics_process(delta: float) -> void:	
	$"../..".burrowed = true;
	
	if Input.is_action_just_pressed("key_down"):
		$"../../AnimatedSprite2D".animation = "idle" 
		get_parent().switch_to_state("above_state")
