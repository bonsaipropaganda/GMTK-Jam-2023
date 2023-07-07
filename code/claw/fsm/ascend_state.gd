extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	claw.position.y -= claw.ascending_speed * delta
	
	# When the claw reaches the top
	if claw.position.y <= 0.0:
		claw.position.y = 0.0
		fsm.switch_to_state("HomingState")
