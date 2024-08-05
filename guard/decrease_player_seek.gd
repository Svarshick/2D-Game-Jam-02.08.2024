extends ActionLeaf

func tick(actor, blackboard):
	var noticed_factor
	if actor.player_was_noticed:
		noticed_factor = 2
	else:
		noticed_factor = 1
	actor.seek_degree -= noticed_factor * get_physics_process_delta_time()
