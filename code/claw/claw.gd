class_name Claw
extends AnimatableBody2D

const SLOW_DOWN_SPEED = 5

@export var target: Node2D # TOOD: change to player type

## Horizontal speed of the claw
@export var homing_speed: float = 200.0

## The speed at wich it tries to catch the player
@export var descending_speed: float = 250.0
## The speed at wich the claw goes back up
@export var ascending_speed: float = 200.0
## The horizontal distance at which the claw tries to grab
@export var grab_distance: float = 20

## If the player is inside this area, close the hand
@onready var hand_area: Area2D = $HandArea

@onready var anim_player: AnimationPlayer = $AnimationPlayer

var set_homing_speed: float = homing_speed
var set_descending_speed: float = descending_speed
var set_ascending_speed: float= ascending_speed

func _physics_process(delta):
	if $"../Player".burrowed:
		if (homing_speed > 0):
			homing_speed -= SLOW_DOWN_SPEED
		else:
			homing_speed = 0;
		if (descending_speed > 0):
			descending_speed -= SLOW_DOWN_SPEED
		else:
			descending_speed = 0;
		if (ascending_speed > 0):
			ascending_speed -= SLOW_DOWN_SPEED
		else:
			ascending_speed = 0;
	else:
		homing_speed = set_homing_speed
		descending_speed = set_descending_speed
		ascending_speed = set_ascending_speed
