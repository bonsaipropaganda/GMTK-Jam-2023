extends Node2D

signal new_room_instanced
signal game_ending

const PauseMenu: PackedScene = preload("res://scenes/GUI/pause_menu.tscn")

var current_room = 1

# preloaded scenes
var room_2 = preload("res://scenes/rooms/room_2.tscn").instantiate()
var room_3 = preload("res://scenes/rooms/room_3.tscn").instantiate()
var room_4 = preload("res://scenes/rooms/room_4.tscn").instantiate()
var room_5 = preload("res://scenes/rooms/room_5.tscn").instantiate()
var end_screen = preload("res://scenes/GUI/end_screen.tscn").instantiate()

func _input(event):
	if event.is_action_pressed("pause"):
		var pause: Node = PauseMenu.instantiate()
		add_child(pause)



func _on_level_passed():
	if current_room == 1:
		$Room_1.queue_free()
		room_2.connect("game_over_signal", _on_game_over)
		add_child(room_2)
		new_room_instanced.emit()
	elif current_room == 2:
		$Room_2.queue_free()
		room_3.connect("game_over_signal", _on_game_over)
		add_child(room_3)
		new_room_instanced.emit()
	elif current_room == 3:
		$Room_3.queue_free()
		room_4.connect("game_over_signal", _on_game_over)
		add_child(room_4)
		new_room_instanced.emit()
	elif current_room == 4:
		$Room_4.queue_free()
		room_5.connect("game_over_signal", _on_game_over)
		add_child(room_5)
		new_room_instanced.emit()
	elif current_room == 5:
		# you win screen
		$Room_5.queue_free()
		add_child(end_screen)
		game_ending.emit()


func _on_new_room_instanced():
	current_room += 1
	$LevelLabel.text = "Level " + str(current_room)


func _on_game_ending():
	$TimeLeftLabel.queue_free()
	$LevelLabel.hide()
	await get_tree().create_timer(10).timeout
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")


func _on_game_over():
	$TimeLeftLabel.reset()
