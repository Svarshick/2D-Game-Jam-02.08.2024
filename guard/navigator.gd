extends NavigationAgent2D

@onready var guard = $".."
var point_number = 0

func _ready():
	navigation_finished.connect(on_reached_target)


func on_reached_target():
	if guard.status == guard.statuses.DEFAULT:
		var position = guard.default_walking[point_number]
		target_position = position
		point_number += 1
		point_number = point_number % guard.default_walking.size()
