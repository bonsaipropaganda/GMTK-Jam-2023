extends Area2D

signal player_caught()

var walk_direction: String = "right"
var shadow_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# set the shadow speed
	$AnimationPlayer.speed_scale = shadow_speed
	
	#Set the animation according to the direction
	if(walk_direction == "right"):
		$AnimationPlayer.current_animation = "Pass_LeftToRight"
	else:
		$AnimationPlayer.current_animation = "Pass_RightToLeft"
		$Sprite2D.set_flip_h(true)
		$CollisionPolygon2D.scale.x = -1.0
	
	$AnimationPlayer.play()
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player and not body.is_burrowed:
		player_caught.emit()
		# HACK:
		body.claw_caught()
