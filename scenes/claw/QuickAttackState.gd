extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	var y_direction: float = sign(claw.target.position.y - claw.position.y)
	claw.position.y += y_direction * 5 * claw.descending_speed * delta
	
	# Start to grab the player if in the hand or if at bottom of room
	if claw.hand_area.has_overlapping_bodies() or claw.position.y > 300:
		print("Switched!")
		fsm.switch_to_state("ClosingState")
	
