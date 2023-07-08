class_name Claw
extends AnimatableBody2D

@export var target: Node2D # TOOD: change to player type


@export_group("Movement")
## Horizontal speed of the claw
@export var homing_speed: float = 200.0
## The speed at wich it tries to catch the player
@export var descending_speed: float = 250.0
## The speed at wich the claw goes back up
@export var ascending_speed: float = 200.0
## The horizontal distance at which the claw tries to grab
@export var grab_distance: float = 20

@export var burrowed_deceleration: float = 600.0


## If the player is inside this area, close the hand
@onready var hand_area: Area2D = $HandArea

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var set_homing_speed: float = homing_speed
var set_descending_speed: float = descending_speed
var set_ascending_speed: float = ascending_speed

var is_target_burrowed: bool = false

var caught_bodies: Array[Node2D] = []
var target_caught: bool = false


func _physics_process(delta):
	if not is_target_burrowed:
		homing_speed = set_homing_speed
		descending_speed = set_descending_speed
		ascending_speed = set_ascending_speed
		return
	
	# Decelerate if we don't see the target
	if (homing_speed > 0):
		homing_speed -= burrowed_deceleration * delta
	else:
		homing_speed = 0
	if (descending_speed > 0):
		descending_speed -= burrowed_deceleration * delta
	else:
		descending_speed = 0
	if (ascending_speed > 0):
		ascending_speed -= burrowed_deceleration * delta
	else:
		ascending_speed = 0


func _closed() -> void:
	caught_bodies = hand_area.get_overlapping_bodies()
	
	# Immobilize bodies
	for body in caught_bodies:
		body.set_physics_process(false)
		body.set_physics_process_internal(false)
		body.reparent(self)
		
		if body.has_method("caught"):
			body.caught()
	
	if target in caught_bodies:
		target_caught = true
		target = null
	
	# Reopen if empty
	if caught_bodies.is_empty():
		anim_player.play_backwards("close")
	
	$ClawFSM.switch_to_state("AscendState")


func _on_target_burrow_change(state: bool) -> void:
	is_target_burrowed = state
