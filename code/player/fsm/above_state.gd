extends PlayerState


func _physics_process(delta: float) -> void:
	# Recover breath
	if player.air < 100.0:
		player.air += player.air_recover_speed * delta
		
		if player.air >= 99.5:
			player.air = 100.0
			player.breath_bar.visible = false
	
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("key_left", "key_right")
	if direction:
		player.velocity.x = direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

	player.move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if player.air == 100.0 and event.is_action_pressed("key_down") and player.is_on_floor():
		fsm.switch_to_state("BelowState")
		get_viewport().set_input_as_handled()


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.sprite.animation = "idle"
	)
