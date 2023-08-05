class_name Claw
extends AnimatableBody2D

## Signal sent when the target has been caught, used for game over
signal target_caught()


@export var target: Node2D
@export var drop_hole: Node2D

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

@export_group("Quick Attack")
## The speed at which the claw descends during a quick attack
@export var quick_attack_speed: float = 1000.0
## The average length of time between each quick attack
@export var quick_attack_timer: float = 7.0
## Time between becoming active and actually attacking to allow the player to respond
@export var quick_attack_buffer: float = 2.0

## If the player is inside this area, close the hand
@onready var hand_area: Area2D = $HandArea

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var initial_y: float = position.y

@onready var set_homing_speed: float = homing_speed
@onready var set_descending_speed: float = descending_speed

var is_target_burrowed: bool = false

var caught_bodies: Array[Node2D] = []
var previous_parents: Array[Node] = []
var is_target_caught: bool = false


func _physics_process(delta):
	if not is_target_burrowed:
		homing_speed = set_homing_speed
		descending_speed = set_descending_speed
		return

	# Decelerate if we don't see the target
	if homing_speed > 0:
		homing_speed -= burrowed_deceleration * delta
	else:
		homing_speed = 0
	if descending_speed > 0:
		descending_speed -= burrowed_deceleration * delta
	else:
		descending_speed = 0


func _closed() -> void:
	var bodies_in_hand = hand_area.get_overlapping_bodies()
	caught_bodies = []
	
	for body in bodies_in_hand:
		if body.has_method(&"claw_can_catch") and not body.claw_can_catch():
			continue
		caught_bodies.push_back(body)
	
	# Immobilize bodies
	for body in caught_bodies:
		previous_parents.push_back(body.get_parent())
		body.reparent(self)
		
		if body.has_method(&"claw_caught"):
			body.claw_caught()
	
	if target in caught_bodies:
		is_target_caught = true
		target = null
		target_caught.emit()
	
	# Reopen if empty
	if caught_bodies.is_empty():
		anim_player.play(&"open")
	
	$ClawFSM.switch_to_state("AscendState")


func _opened() -> void:
	for i in caught_bodies.size():
		var body: Node2D = caught_bodies[i]
		var parent: Node = previous_parents[i]
		body.reparent(parent)
		
		if body.has_method(&"claw_release"):
			body.claw_release()
	
	caught_bodies = []
	previous_parents = []
	
	$ClawFSM.switch_to_state("HomingState")


func _on_target_burrow_change(state: bool) -> void:
	is_target_burrowed = state
