extends HBoxContainer

@export var node_group: String
@export var variable_name: String

@onready var parameter_name = $ParameterName
@onready var parameter_value = $ParameterValue

@onready var config_stats = ConfigFile.new()
@onready var err = config_stats.load("res://resources/stats.cfg")

func fill(n_group: String, v_name: String):
	node_group = n_group
	variable_name = v_name
	var node = get_tree().get_first_node_in_group(node_group)
	parameter_name.text = variable_name
	parameter_value.text = str(node.get_indexed(variable_name))

func _on_parameter_value_text_changed(new_text):
	var nodes = get_tree().get_nodes_in_group(node_group)
	for node in nodes:
		node.set_indexed(variable_name, parameter_value.text.to_float())
		config_stats.set_value("guard", variable_name, parameter_value.text.to_float())
	config_stats.save("res://resources/stats.cfg")
