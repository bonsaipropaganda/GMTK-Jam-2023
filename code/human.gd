extends Area2D

@onready var walk_anim = $AnimationPlayer.get_animation("walk")

# Called when the node enters the scene tree for the first time.
func _ready():
#	walk_anim.set_loop(true)
	$AnimationPlayer.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
