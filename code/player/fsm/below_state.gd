extends PlayerState


func _physics_process(delta: float) -> void:
	player.breath -= 50.0 * delta


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_down") and player.is_on_floor():
		fsm.switch_to_state("AboveState")
		get_viewport().set_input_as_handled()


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.is_burrowed = true
		player.sprite.animation = "burrowed"
		player.breath = 100.0
	)
	state_exited.connect(func(_to: State): player.is_burrowed = false)
