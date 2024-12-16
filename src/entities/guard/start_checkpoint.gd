extends Checkpoint


func _ready() -> void:
	super()
	var parent = get_parent()
	global_position = parent.global_position
