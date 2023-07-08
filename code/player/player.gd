class_name Player
extends CharacterBody2D

signal burrowed(state: bool)


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var air_expire_speed: float = 50.0
@export var air_recover_speed: float = 25.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var is_burrowed = false:
	set(value):
		is_burrowed = value
		burrowed.emit(value)


var air: float = 100.0:
	set(value):
		air = value
		$breath_bar.value = value


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var breath_bar: ProgressBar = $breath_bar


## Called when the body is caucht by the claw
func claw_caught() -> void:
	$PlayerFSM.switch_to_state("CaughtState")


func claw_release() -> void:
	$PlayerFSM.switch_to_state("DropHoleFallState")


func claw_can_catch() -> bool:
	return not is_burrowed
