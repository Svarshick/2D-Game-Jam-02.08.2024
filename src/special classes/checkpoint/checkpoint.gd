@tool
extends Node2D

class_name Checkpoint

@export var scale_rotation_speed: bool = true
var scale_was_updated = false

@export var wait_time: float = 2.0:
	set(value):
		if (scale_rotation_speed and not scale_was_updated):
			scale_was_updated = true
			turns_count = turns_count * value / wait_time
		wait_time = value
		scale_was_updated = false

@export var turns_count: float = 2.0:
	set(value):
		if (scale_rotation_speed and not scale_was_updated):
			scale_was_updated = true
			wait_time = wait_time * value / turns_count
		turns_count = value
		scale_was_updated = false

@export var turn_angle: float = 60

@onready var timer = Timer.new()


#func _init(init_position: Vector2 = global_position) -> void:
	#global_position = init_position


func _ready() -> void:
	top_level = true # for preventing changing coordinates along parent (Guard)
	var parent = get_parent()
		
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = wait_time
