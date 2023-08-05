extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return


	claw.position.y += claw.quick_attack_speed * delta
	
	# Start to grab the player if in the hand or if at bottom of room
	if claw.hand_area.has_overlapping_bodies() or claw.position.y > 300:
		$"../../QuickAttack/Collision".play()
		print("Switched!")
		Global.camera.shake(0.5,50,20)
		fsm.switch_to_state("ClosingState")
	
