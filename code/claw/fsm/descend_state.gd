extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	var y_direction: float = sign(claw.target.position.y - claw.position.y)
	claw.position.y += y_direction * claw.descending_speed * delta
	
	# Start to grab the player if in the hand
	if not claw.is_target_burrowed and claw.hand_area.has_overlapping_bodies():
		fsm.switch_to_state("ClosingState")
	
	# Go back to homing state if too far from the target
	var distance: float = abs(claw.target.position.x - claw.position.x)
	if distance > claw.grab_distance:
		fsm.switch_to_state("AscendState")
