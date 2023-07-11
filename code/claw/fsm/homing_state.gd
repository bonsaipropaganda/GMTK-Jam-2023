extends ClawState


func _physics_process(delta: float) -> void:
	if not claw.target:
		return
	
	var direction: float = claw.target.position.x - claw.position.x
	var distance: float = abs(direction)
	direction = sign(direction)
	
	claw.position.x += direction * claw.homing_speed * delta
	
	if distance < claw.grab_distance:
		fsm.switch_to_state("DescendState")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"quick"):
		fsm.switch_to_state("QuickAttackState")
