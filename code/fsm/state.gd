class_name State
extends Node


signal state_entered(from: State)
signal state_exited(to: State)


func _ready() -> void:
	_set_enabled(false)
	
	# Connect signals to corresponding methods
	if has_method(&"_state_entered"):
		state_entered.connect(func(from: State): call(&"_state_entered", from))
	if has_method(&"_state_exited"):
		state_exited.connect(func(to: State): call(&"_state_exited", to))


func _enter(from: State) -> void:
	state_entered.emit(from)
	_set_enabled(true)


func _exit(to: State) -> void:
	state_exited.emit(to)
	_set_enabled(false)


func _set_enabled(enable: bool) -> void:
	set_process(enable)
	set_physics_process(enable)
