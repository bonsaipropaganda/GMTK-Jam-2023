extends RigidBody2D


func claw_caught() -> void:
	freeze = true
	$CollisionShape2D.disabled = true


func claw_release() -> void:
	freeze = false
	$CollisionShape2D.disabled = false
	set_collision_mask_value(4, false) # Disable collision with drop hole
	# TOFIX ? : if it does not enter the pipe it is not reset, for now it does not give rise to any issue
	z_index = -1
	linear_velocity = Vector2.ZERO


#func _on_body_entered(body: Node2D) -> void:
#	if body.get_collision
