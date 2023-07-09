extends PlayerState


var jump_last_press: float = 100.0
var last_ground: float     = 100.0


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
	last_ground     += delta
	if player.is_on_floor():
		last_ground = 0.0
	
	jump_last_press += delta
	if jump_last_press < player.jump_buffer and last_ground < player.coyote_time:
		player.velocity.y = player.jump_velocity
		player.sprite.set_animation("jumping_start")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("key_left", "key_right")
	if direction:
		player.velocity.x = direction * player.speed
		# Flip according to direction
		if(player.velocity > Vector2(0,0)):
			player.sprite.set_flip_h(false)
		else:
			player.sprite.set_flip_h(true)
		#Set to running if on ground
		if(player.is_on_floor() and player.sprite.animation != "running" and player.sprite.animation != "out_of_burrow"):
			player.sprite.set_animation("running")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		if(player.sprite.animation != "out_of_burrow" and player.is_on_floor()):
			player.sprite.set_animation("idle")

	player.move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if player.air > 0 and event.is_action_pressed("key_down") and player.is_on_floor():
		fsm.switch_to_state("BelowState")
		get_viewport().set_input_as_handled()
	
	if event.is_action_pressed(&"jump"):
		jump_last_press = 0.0


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.sprite.animation = "out_of_burrow"
		player.sprite.play()
	)
