extends Node2D

class_name Checkpoint

@onready var timer = $Timer

func _ready() -> void:
	print("_ready(): " + str(self))


func _on_timer_timeout() -> void:
	pass # Replace with function body.
