extends ClawState


func _physics_process(delta: float) -> void:
	if not is_instance_valid(claw.target):
		return
	
	var dir: float = claw.target.position.x - claw.position.x
	dir = sign(dir)
	
	claw.position.x += dir * claw.homing_speed * delta
