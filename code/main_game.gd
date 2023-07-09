extends Node2D

signal new_room_instanced

const PauseMenu: PackedScene = preload("res://scenes/GUI/pause_menu.tscn")

var current_room = 1
var room_2 = preload("res://scenes/rooms/room_2.tscn").instantiate()
var room_3 = preload("res://scenes/rooms/room_3.tscn").instantiate()
var room_4 = preload("res://scenes/rooms/room_4.tscn").instantiate()
var room_5 = preload("res://scenes/rooms/room_5.tscn").instantiate()

func _input(event):
	if event.is_action_pressed("pause"):
		var pause: Node = PauseMenu.instantiate()
		add_child(pause)




func _on_level_passed():
	if current_room == 1:
		$Room_1.queue_free()
		add_child(room_2)
		new_room_instanced.emit()
	elif current_room == 2:
		$Room_2.queue_free()
		add_child(room_3)
		new_room_instanced.emit()
	elif current_room == 3:
		$Room_3.queue_free()
		add_child(room_4)
		new_room_instanced.emit()
	elif current_room == 4:
		$Room_4.queue_free()
		add_child(room_5)
		new_room_instanced.emit()
	elif current_room == 5:
		# you win screen
		pass
#		$Room_2.queue_free()
#		add_child(room_3)
#		new_room_instanced.emit()


func _on_new_room_instanced():
	current_room += 1
