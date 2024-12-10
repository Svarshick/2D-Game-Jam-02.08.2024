extends VBoxContainer

@onready var main_menu = $"../MainMenu"
var ParameterSettings = load("res://src/ui/ParameterSettings.tscn")


func _ready():
	hide()
	add_parameters_from("guard")


func add_parameters_from(target_group: String):
	var parameters = get_tree().get_first_node_in_group(target_group).get_parameter_names()
	for parameter in parameters:
		var new_parameter_setting = ParameterSettings.instantiate()
		add_child(new_parameter_setting)
		new_parameter_setting.fill(target_group, parameter)


func enter():
	show()


func exit():
	hide()


func on_input(event):
	if Input.is_action_just_pressed("back"):
		Events.change_menu_window.emit("main_menu")
