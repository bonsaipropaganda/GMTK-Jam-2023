class_name Player
extends CharacterBody2D

signal burrowed(state: bool)


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var is_burrowed = false:
	set(value):
		is_burrowed = value
		burrowed.emit(value)
		$breath_bar.visible = value


var breath: float = 100.0:
	set(value):
		breath = value
		$breath_bar.value = value


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


## Called when the body is caucht by the claw
func caught() -> void:
	$PlayerFSM.switch_to_state("CaughtState")
