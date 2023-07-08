extends Node2D


var GameOverScreen: PackedScene = preload("res://scenes/GUI/game_over.tscn")


func _on_player_caught() -> void:
	var game_over := GameOverScreen.instantiate()
	add_child(game_over)
