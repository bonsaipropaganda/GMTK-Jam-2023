extends PlayerState


func _physics_process(delta: float) -> void:
	var air_lose_speed: float = 100.0 / player.burrow_total_time
	player.air -= air_lose_speed * delta
	
	if player.air <= 0.5:
		player.air = 0.0
		fsm.switch_to_state("AboveState")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_down") and player.is_on_floor():
		fsm.switch_to_state("AboveState")
		get_viewport().set_input_as_handled()


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.is_burrowed = true
		player.breath_bar.visible = true
		player.sprite.animation = "into_burrow"
		#player.air = 100.0
		
		player.collision_shape.disabled = true
	)
	state_exited.connect(func(_to: State):
		player.is_burrowed = false
		player.collision_shape.disabled = false
	)
