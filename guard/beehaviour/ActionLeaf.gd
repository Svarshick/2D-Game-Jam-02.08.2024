extends ActionLeaf

func tick(actor, _blackboard):
	actor.move_along_path(get_physics_process_delta_time())
	var player = actor.player
	if actor.position.distance_to(player.position) < 100:
		return SUCCESS
	return RUNNING
