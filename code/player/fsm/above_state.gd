extends PlayerState


var jump_last_press: float   = INF
var burrow_last_press: float = INF
var last_ground: float       = INF

var jump_cancel: bool = false

func _physics_process(delta: float) -> void:
	# Burrow
	burrow_last_press += delta
	if burrow_last_press < player.grounded_input_buffer and player.is_on_floor():
		burrow_last_press = INF
		fsm.switch_to_state("BelowState")
		return
	
	# Recover breath
	if player.air < 100.0:
		var recover_speed: float = 100.0 / player.burrow_recover_time
		player.air += recover_speed * delta
		
		if player.air >= 99.5:
			player.air = 100.0
			player.breath_bar.visible = false
	
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta

	# Handle Jump.
	# Coyote time + Input buffering
	jump_last_press += delta
	last_ground     += delta
	if player.is_on_floor():
		last_ground = 0.0
	
	# Jump acton
	if jump_last_press < player.grounded_input_buffer and last_ground < player.coyote_time:
		player.velocity.y = -player.jump_velocity
		player.sprite.set_animation("jumping_start")
	
	# Jump cancel
	if jump_cancel:
		var y_decel: float = player.jump_velocity / player.jump_cancel_time
		player.velocity.y = move_toward(player.velocity.y, 0.0, y_decel * delta)
		
		if player.velocity.y >= 0.0:
			jump_cancel = false
	
	# Left right movement
	var direction = Input.get_axis("key_left", "key_right")
	
	if direction: # If the direction is non-null, accelerate
		var target_speed: float = direction * player.max_speed
		var accel: float = 0.0
		
		# If we're going in the same direction as the input
		if sign(direction) * sign(player.velocity.x) >= 0.0:
			accel = player.max_speed / player.acceleration_time
		else:
			accel = player.max_speed / player.turn_time # Accelerate faster when turning
		
		if not player.is_on_floor(): # Less control in air
			accel *= player.in_air_control
		
		player.velocity.x = move_toward(player.velocity.x, target_speed, accel * delta)
		
		# Flip according to direction
		if player.velocity.x >= 0.0:
			player.sprite.set_flip_h(false)
		else:
			player.sprite.set_flip_h(true)
			
		# Set to running if on ground
		if player.is_on_floor() and player.sprite.animation != "running" and player.sprite.animation != "out_of_burrow":
			player.sprite.set_animation("running")
	else:
		var decel: float = player.max_speed / player.deceleration_time
		player.velocity.x = move_toward(player.velocity.x, 0, decel * delta)
		
		if player.sprite.animation != "out_of_burrow" and player.is_on_floor():
			player.sprite.set_animation("idle")

	player.move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"burrow"):
		burrow_last_press = 0.0
	
	if event.is_action_pressed(&"jump"):
		jump_last_press = 0.0
	
	if event.is_action_released(&"jump") and player.velocity.y < 0.0:
		jump_cancel = true
	


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.sprite.animation = "out_of_burrow"
		player.sprite.play()
	)
