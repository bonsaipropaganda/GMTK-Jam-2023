class_name State
extends Node


signal state_entered(from: State)
signal state_exited(to: State)

var is_current_state: bool = false


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_READY: # using notification so that the _ready function can be overrwitten easily in child classes
			_set_enabled(is_current_state)


func _enter(from: State) -> void:
	is_current_state = true
	state_entered.emit(from)
	_set_enabled(true)


func _exit(to: State) -> void:
	is_current_state = false
	state_exited.emit(to)
	_set_enabled(false)


func _set_enabled(enable: bool) -> void:
	set_process(enable)
	set_physics_process(enable)
