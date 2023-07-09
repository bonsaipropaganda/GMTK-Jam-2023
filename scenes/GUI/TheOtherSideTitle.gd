extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(240,90), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", Vector2(240,80), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops(50)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
