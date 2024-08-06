extends ActionLeaf

func tick(actor, blackboard):
	var noticed_factor
	if actor.player_was_noticed:
		noticed_factor = 20
	else:
		noticed_factor = 10
	actor.seek_degree += noticed_factor * get_physics_process_delta_time()
	return SUCCESS
