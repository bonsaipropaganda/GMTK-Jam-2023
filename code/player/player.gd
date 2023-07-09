class_name Player
extends CharacterBody2D

signal burrowed(state: bool)


@export var grounded_input_buffer: float = 0.1

@export_group("Movement")
@export var acceleration_time: float = 0.4
@export var turn_time: float         = 0.05
@export var deceleration_time: float = 0.2

@export var max_speed: float = 200.0
@export var jump_velocity: float = 300.0
@export var jump_cancel_time: float = 0.2
@export var in_air_control: float = 0.8

@export var coyote_time: float = 0.085

@export_group("Burrow")
@export var burrow_total_time: float = 2.0
@export var burrow_recover_time: float = 4.0

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
	

func _on_shadow_detection_area_entered(_area):
	# only get caught if you are not burrowed
	if is_burrowed == false:
		$PlayerFSM.switch_to_state("CaughtState")


func _on_animated_sprite_2d_animation_looped():
	match $AnimatedSprite2D.animation:
		"into_burrow":
			$AnimatedSprite2D.animation = "burrowed"
		"out_of_burrow":
			$AnimatedSprite2D.animation = "idle"
		"jumping_start":
			$AnimatedSprite2D.animation = "jumping"
