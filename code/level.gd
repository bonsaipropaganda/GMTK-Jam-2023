class_name Level
extends Node2D


signal game_over(msg: String)
signal game_won()


func set_level_number(number: int) -> void:
	$HUD/LevelLabel.text = "Level " + str(number)
