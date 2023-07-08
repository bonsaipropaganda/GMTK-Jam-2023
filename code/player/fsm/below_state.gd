extends PlayerState


func _physics_process(delta: float) -> void:
	player.air -= 50.0 * delta
	
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
		player.sprite.animation = "burrowed"
		player.air = 100.0
	)
	state_exited.connect(func(_to: State): player.is_burrowed = false)
