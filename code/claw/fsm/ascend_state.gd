extends ClawState


func _physics_process(delta: float) -> void:
	claw.position.y -= claw.ascending_speed * delta
	
	# When the claw reaches the top
	if claw.position.y <= claw.initial_y:
		claw.position.y = claw.initial_y
		
		if claw.caught_bodies.is_empty():
			fsm.switch_to_state("HomingState")
		else:
			fsm.switch_to_state("GotoDropHoleState")
