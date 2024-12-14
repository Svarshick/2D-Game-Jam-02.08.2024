extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status == actor.statuses.SEE:
		actor.make_path(actor.player.global_position)
		actor.move_along_path(get_process_delta_time())
		return RUNNING
	return FAILURE
