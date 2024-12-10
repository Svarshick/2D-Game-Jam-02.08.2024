extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status == actor.statuses.SEE:
		return SUCCESS
	if actor.status < actor.statuses.WORRY:
		return FAILURE
	return RUNNING
