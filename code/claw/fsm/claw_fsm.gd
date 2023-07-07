@tool
class_name ClawFSM
extends FiniteStateMachine


var claw: Claw


func _ready() -> void:
	propagate_call(&"set", [&"claw", get_parent()])
