extends Node2D

signal new_room_instanced

const PauseMenu: PackedScene = preload("res://scenes/GUI/pause_menu.tscn")
const GameOverScreen: PackedScene = preload("res://scenes/GUI/game_over.tscn")
const LevelTransition: PackedScene = preload("res://scenes/GUI/level_transition.tscn")


var current_level: int = 1
## Paths to all levels
const LEVELS: Array[PackedScene] = [
	preload("res://scenes/rooms/room_1.tscn"),
	preload("res://scenes/rooms/room_2.tscn"),
	preload("res://scenes/rooms/room_3.tscn"),
	preload("res://scenes/rooms/room_4.tscn"),
	preload("res://scenes/rooms/room_5.tscn"),
	preload("res://scenes/GUI/end_screen.tscn")
]


func _input(event):
	if event.is_action_pressed("pause"):
		var pause: Node = PauseMenu.instantiate()
		add_child(pause)


func load_level(index: int) -> void:
	current_level = index
	
	# Remove currently loaded level (if any)
	for c in $Level.get_children():
		c.queue_free()
	
	# Load the appropriate level
	var level_scene: Node = LEVELS[index-1].instantiate()
	if level_scene is Level:
		level_scene.game_over.connect(_on_game_over, CONNECT_ONE_SHOT)
		level_scene.game_won.connect(_on_game_won, CONNECT_ONE_SHOT)
		level_scene.set_level_number(index)
	$Level.add_child(level_scene)
	


func _on_game_over(msg: String) -> void:
	var game_over := GameOverScreen.instantiate()
	game_over.try_again_button_pressed.connect(load_level.bind(current_level))
	add_child(game_over)


func _on_game_won() -> void:
	var level_transition_scene: Node = LevelTransition.instantiate()
	level_transition_scene.next_level_button_pressed.connect(load_level.bind(current_level + 1))
	level_transition_scene.retry_button_pressed.connect(load_level.bind(current_level))
	add_child(level_transition_scene)
