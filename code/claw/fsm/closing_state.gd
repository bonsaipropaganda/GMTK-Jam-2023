extends ClawState


func _state_entered(_from: ClawState) -> void:
	claw.anim_player.play(&"close")


func _ready() -> void:
	state_entered.connect(_state_entered)
