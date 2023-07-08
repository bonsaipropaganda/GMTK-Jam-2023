extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.drop_hole:
		return
	
	var direction: float = claw.drop_hole.position.x - claw.position.x
	var distance: float = abs(direction)
	direction = sign(direction)
	
	claw.position.x += direction * claw.homing_speed * delta
	
	if distance < 10.0:
		fsm.switch_to_state("DroppingState")
