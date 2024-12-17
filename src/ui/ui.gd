extends CanvasLayer

@onready var windows = {
	"main_menu": $CenterContainer/MainMenu,
	"settings": $CenterContainer/GuardianSettings,
}
@onready var current_window = $CenterContainer/MainMenu


func _ready():
	Events.change_menu_window.connect(on_change_menu_window)


func on_change_menu_window(window_name: String):
	current_window.exit()
	current_window = windows.get(window_name)
	current_window.enter()


func _unhandled_input(event):
	current_window.on_input(event)	
