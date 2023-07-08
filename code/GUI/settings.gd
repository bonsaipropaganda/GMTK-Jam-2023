extends CanvasLayer


@onready var master_bus: int = AudioServer.get_bus_index(&"Master")
@onready var music_bus : int = AudioServer.get_bus_index(&"Music")
@onready var sfx_bus   : int = AudioServer.get_bus_index(&"Sfx")


func _ready() -> void:
	get_tree().paused = true
	
	_set_slider_volume(%MasterVolume, master_bus)
	_set_slider_volume(%MusicVolume , music_bus)
	_set_slider_volume(%SfxVolume   , sfx_bus)


func _set_slider_volume(slider: Slider, bus: int) -> void:
	var volume_db: float = AudioServer.get_bus_volume_db(bus)
	slider.value = db_to_linear(volume_db)


func _set_bus_volume(slider: Slider, bus: int) -> void:
	AudioServer.set_bus_volume_db(bus, linear_to_db(slider.value))


func _on_master_volume_changed(_value: float) -> void:
	_set_bus_volume(%MasterVolume, master_bus)


func _on_music_volume_changed(_value: float) -> void:
	_set_bus_volume(%MusicVolume , music_bus)


func _on_sfx_volume_changed(_value: float) -> void:
	_set_bus_volume(%SfxVolume   , sfx_bus)


func _on_back_pressed() -> void:
	get_tree().paused = false
	queue_free()
