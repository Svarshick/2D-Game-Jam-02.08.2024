extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard) -> void:
	blackboard.set_value("target is reached", false)
	
	var checkpoint = actor.checkpoints.next()
	actor.make_path(checkpoint.global_position)
	
	actor.navigator.navigation_finished.connect(on_reach_checkpoint.bind(blackboard))


func tick(actor: Node, blackboard: Blackboard) -> int:
	if blackboard.get_value("target is reached"):
		print("tick() Walk: reached")
		return FAILURE
	actor.move_along_path(get_process_delta_time())
	return RUNNING


func on_reach_checkpoint(blackboard: Blackboard):
	blackboard.set_value("target is reached", true)
