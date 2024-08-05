extends VBoxContainer

@onready var main_menu = $"../MainMenu"
var ParameterSettings = load("res://ui/ParameterSettings.tscn")
const target_group = "guard"

func _ready():
	hide()
	var parameters = get_tree().get_first_node_in_group(target_group).get_parameter_names()
	for parameter in parameters:
		var new_parameter = ParameterSettings.instantiate()
		add_child(new_parameter)
		new_parameter.fill(target_group, parameter)


func enter():
	show()


func exit():
	hide()


func on_input(event):
	if Input.is_action_just_pressed("back"):
		Events.change_menu_window.emit("main_menu")

