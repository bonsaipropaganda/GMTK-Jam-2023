extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	var direction: float = claw.target.position.x - claw.position.x
	var distance: float = abs(direction)
	direction = sign(direction)
	
	claw.position.x += direction * claw.homing_speed * delta
	
	if distance < claw.grab_distance:
		if $"../../QuickAttack".quick_attack_ready():
			fsm.switch_to_state("QuickAttackState")
			$"../../QuickAttack".restart_quick_attack()
		else:
			fsm.switch_to_state("DescendState")
