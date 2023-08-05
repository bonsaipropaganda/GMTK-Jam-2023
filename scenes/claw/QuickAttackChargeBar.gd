@tool
extends ProgressBar

var yellow = Color(1, 1, 0, 1)
var orange = Color(1, 0.647059, 0, 1)
var red = Color(1, 0, 0, 1)

@onready var current_color = yellow

func _ready():
	show_percentage = false
	
func _draw():
	draw_circle_arc_poly(Vector2(0,-100), 10, 0, 360, current_color)
	pass

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)


func _on_quick_attack_timer_timeout():
	if (current_color == yellow):
		current_color = orange
		queue_redraw()
		$QuickAttackTimer.set_wait_time(get_parent().quick_attack_buffer)
		$QuickAttackTimer.start()
		$OrangeBuzzer.play()
		
	elif (current_color == orange):
		current_color = red
		$Buzzer.play()
		queue_redraw()
		$QuickAttackTimer.stop()

func quick_attack_ready() -> bool:
	return current_color == red
	
func restart_quick_attack() -> void:
	current_color = yellow
	queue_redraw()
	$QuickAttackTimer.set_wait_time(get_parent().quick_attack_timer)
	$QuickAttackTimer.start()
