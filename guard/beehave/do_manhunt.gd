extends ActionLeaf

func tick(actor, blackboard) -> int:
	actor.move_along_path(get_physics_process_delta_time())
	if actor.status == actor.statuses.WORRY:
		#print("Manhunt running with: " + str(actor.seek_degree))
		return RUNNING
	if actor.status == actor.statuses.SEE:
		#print("Manhunt success with: " + str(actor.seek_degree))
		return SUCCESS
	#print("Manhunt failed with: " + str(actor.seek_degree))
	return FAILURE 
