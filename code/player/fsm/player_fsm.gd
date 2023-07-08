@tool
class_name PlayerFSM
extends FiniteStateMachine


var player: Player


func _ready() -> void:
	propagate_call(&"set", [&"player", get_parent()])
