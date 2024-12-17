extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard):
	var checkpoint = actor.checkpoints.next()
	actor.current_speed = actor.walk_speed
	actor.make_path(checkpoint.global_position)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.navigator.is_navigation_finished():
		return FAILURE
	
	actor.move_along_path(get_process_delta_time())
	actor.set_animation("Move")
	return RUNNING
