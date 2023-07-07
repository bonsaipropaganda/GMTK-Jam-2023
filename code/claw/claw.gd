class_name Claw
extends AnimatableBody2D


@export var target: Node2D # TOOD: change to player type

## Horizontal speed of the claw
@export var homing_speed: float = 100.0

## The speed at wich it tries to catch the player
@export var descending_speed: float = 150.0

