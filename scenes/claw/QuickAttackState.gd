extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	var y_direction: float = sign(claw.target.position.y - claw.position.y)
	claw.position.y += y_direction * claw.quick_attack_speed * delta
	
	# Start to grab the player if in the hand or if at bottom of room
	if claw.hand_area.has_overlapping_bodies() or claw.position.y > 300:
		print("Switched!")
		Global.camera.shake(0.5,50,20)
		fsm.switch_to_state("ClosingState")
	
