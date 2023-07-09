extends Area2D

var walk_direction: String = "right"

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the animation according to the direction
	if walk_direction == "right":
		$AnimationPlayer.current_animation = "Pass_LeftToRight"
	else:
		$AnimationPlayer.current_animation = "Pass_RightToLeft"
		$Sprite2D.set_flip_h(true)
		$CollisionPolygon2D.scale.x = -1.0
	
	$AnimationPlayer.play()
	
