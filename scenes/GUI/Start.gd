extends AnimatedSprite2D

var mouse_in_button := false
var main_game_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(240,160), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", Vector2(240,150), 1).set_trans(Tween.TRANS_SINE)
	tween.set_loops()


func _on_area_2d_mouse_entered():
	var cloudTween = get_tree().create_tween()
	cloudTween.tween_property($"../CloudSprite", "scale", Vector2(2,2), 0.5).set_trans(Tween.TRANS_BOUNCE)
	mouse_in_button = true

func _on_area_2d_mouse_exited():
	set_animation("unpressed")
	mouse_in_button = false

func _input(event):
	if mouse_in_button == true:
		if event.is_action_pressed("l_click"):
			get_tree().change_scene_to_packed(main_game_scene)
