extends Node2D

class_name Checkpoint

@export var wait_time: float = 1.0

var timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	top_level = true
	
	var parent_node = get_parent()
	if parent_node is Node2D:
		global_position = global_position + parent_node.global_position
	
	timer.one_shot = true
	timer.wait_time = wait_time
	timer.start()
	
	print("timer parameters: " + str(timer.wait_time))
