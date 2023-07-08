@tool
class_name FiniteStateMachine
extends Node


@export var current_state: State:
	set(state):
		var previous_state: State = current_state
		current_state = state
		update_configuration_warnings()

		if not Engine.is_editor_hint():
			# Change state status

			if is_instance_valid(previous_state):
				previous_state._exit(state)
			state._enter(current_state)


func switch_to_state(state_name: String) -> void:
	var state: State = get_node_or_null(state_name)
	if not is_instance_valid(state):
		push_error("State %s does not exist" % [state_name])
		return
	if current_state == state:
		return
	current_state = state


func _get_configuration_warnings() -> PackedStringArray:
	var warns := PackedStringArray()
	if not is_instance_valid(current_state):
		warns.push_back("No initial state set")
	return warns
