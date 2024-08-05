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


func _input(event):
	if Input.is_action_just_pressed("pause"):
		_game_paused = not _game_paused


func _on_continue_button_pressed():
	_game_paused = false
