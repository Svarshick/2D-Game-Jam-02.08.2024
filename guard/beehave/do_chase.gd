extends ActionLeaf

func tick(actor, blackboard):
	var player = actor.player
	actor.make_path(player.position)
	actor.move_along_path(get_physics_process_delta_time())
	if actor.status == actor.statuses.SEE:
		#print("Chase running with: " + str(actor.seek_degree))
		return RUNNING
	#print("Chase failed with: " + str(actor.seek_degree))
	return FAILURE
