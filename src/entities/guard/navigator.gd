extends NavigationAgent2D

@onready var guard = $".."
var point_number = 0

func _ready():
	navigation_finished.connect(on_reached_target)


func on_reached_target():
	for checkpoint in guard.checkpoints:
		print("checkpoint coordinate: " + str(checkpoint.global_position))

func _on_path_changed() -> void:
	print("_on_path_changed(): " + str(target_position))
