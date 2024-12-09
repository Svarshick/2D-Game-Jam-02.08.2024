extends ActionLeaf

func tick(actor, blackboard):
	if actor.stay:
		return SUCCESS
	if actor.hasTarget():
		actor.restart_path()
	actor.move_along_path(get_physics_process_delta_time())
	return SUCCESS
	
