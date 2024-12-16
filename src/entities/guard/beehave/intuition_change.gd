extends ActionLeaf

func tick(actor, blackboard):
	actor.seek_degree += actor.seek_increment * get_physics_process_delta_time()
	blackboard.set_value("last player position", actor.player.global_position)
	return SUCCESS
