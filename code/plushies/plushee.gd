extends RigidBody2D


func claw_caught() -> void:
	freeze = true
	$CollisionShape2D.disabled = true
