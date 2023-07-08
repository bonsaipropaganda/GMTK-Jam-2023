extends ClawState


func _physics_process(delta: float) -> void:
	claw.position.y -= claw.ascending_speed * delta
	
	# When the claw reaches the top
	if claw.position.y <= claw.initial_y:
		claw.position.y = claw.initial_y
		fsm.switch_to_state("HomingState")
