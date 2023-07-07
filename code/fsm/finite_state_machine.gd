@tool
class_name FiniteStateMachine
extends Node


@export var current_state: State:
	set(state):
		if is_instance_valid(current_state):
			current_state._exit(state)
		state._enter(current_state)
		current_state = state
		
		update_configuration_warnings()


func switch_to_state(state: State) -> void:
	if current_state == state:
		return
	current_state = state



func _get_configuration_warnings() -> PackedStringArray:
	var warns := PackedStringArray()
	if not is_instance_valid(current_state):
		warns.push_back("No initial state set")
	return warns
