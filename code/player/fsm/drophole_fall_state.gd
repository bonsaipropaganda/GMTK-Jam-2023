extends PlayerState


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	
	player.move_and_slide()


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.set_collision_mask_value(4, false) # Disable collision with drop hole
		player.z_index = -1
		player.sprite.animation = "idle"
	)
