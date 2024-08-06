extends ActionLeaf

func tick(actor, blackboard):
	var player = actor.player
	actor.make_path(player.position)
	actor.move_along_path(get_physics_process_delta_time())
	if actor.current_state == actor.states.SEE:
		return RUNNING
	return FAILURE
