extends ActionLeaf

func tick(actor, blackboard):
	actor.move_along_path(get_physics_process_delta_time())
	if actor.current_state == actor.states.WORRY:
		return RUNNING
	return FAILURE 
