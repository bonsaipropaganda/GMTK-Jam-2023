class_name Claw
extends AnimatableBody2D


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
