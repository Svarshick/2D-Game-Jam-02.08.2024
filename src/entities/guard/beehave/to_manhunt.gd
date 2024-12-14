extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status == actor.statuses.SEE:
		return SUCCESS
	if actor.status < actor.statuses.WORRY:
		return FAILURE
	if !actor.navigator.is_navigation_finished():
		actor.move_along_path(get_process_delta_time())
	return RUNNING
