extends ClawState


func _state_entered(_from: ClawState) -> void:
	print("GRAB !!!")


func _ready() -> void:
	state_entered.connect(_state_entered)
