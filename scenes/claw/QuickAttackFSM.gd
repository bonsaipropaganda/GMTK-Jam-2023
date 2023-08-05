class_name QuickAttackFSM
extends FiniteStateMachine

var quick_attack_display: QuickAttackDisplay

func _ready() -> void:
	propagate_call(&"set", [&"quick_attack_display", get_parent()])
