extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(240,160), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", Vector2(240,150), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	
	
	
	

func _on_area_2d_mouse_entered():
	var cloudTween = get_tree().create_tween()
	cloudTween.tween_property($"../CloudSprite", "scale", Vector2(2,2), 0.5).set_trans(Tween.TRANS_BOUNCE)

func _on_area_2d_mouse_exited():
	set_animation("unpressed")
