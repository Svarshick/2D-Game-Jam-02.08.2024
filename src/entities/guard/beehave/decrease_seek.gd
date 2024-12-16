extends ActionLeaf

func tick(actor: Node, blackboard):
	actor.seek_degree += actor.seek_decrement * get_physics_process_delta_time()
	return SUCCESS
