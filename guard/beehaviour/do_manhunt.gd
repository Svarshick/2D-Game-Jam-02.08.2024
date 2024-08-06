extends ActionLeaf

func tick(actor, blackboard):
	actor.move_along_path(get_physics_process_delta_time())
	if actor.state == actor.states.WORRY:
		print("Manhunt running with: " + str(actor.seek_degree))
		return RUNNING
	if actor.state == actor.states.SEE:
		print("Manhunt success with: " + str(actor.seek_degree))
		return SUCCESS
	print("Manhunt failed with: " + str(actor.seek_degree))
	return FAILURE 
