extends ActionLeaf

func tick(actor, blackboard):
	if not actor.stay:
		actor.move_along_path(get_physics_process_delta_time())
	return SUCCESS
	
