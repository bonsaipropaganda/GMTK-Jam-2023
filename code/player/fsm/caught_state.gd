extends PlayerState


func _ready() -> void:
	state_entered.connect(func(_from: State):
		player.breath_bar.visible = false
	)
