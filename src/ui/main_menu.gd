extends VBoxContainer

var _game_paused: bool = false:
	set(value):
		_game_paused = value
		_on_pause(value)


func _ready():
	Events.game_paused.connect(_on_pause)
	_game_paused = get_tree().is_paused()


func _on_pause(paused: bool):
	get_tree().paused = paused
	if paused:
		show()
	else:
		hide()


func enter():
	show()


func exit():
	hide()


func on_input(event):
	if Input.is_action_just_pressed("back"):
		_game_paused = not _game_paused


func _on_continue_button_pressed():
	_game_paused = false


func _on_settings_button_pressed():
	Events.change_menu_window.emit("settings")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_restart_button_pressed() -> void:
	_game_paused = false
	get_tree().reload_current_scene()
	
