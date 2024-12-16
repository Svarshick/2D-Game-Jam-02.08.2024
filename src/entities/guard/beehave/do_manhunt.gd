extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status >= actor.statuses.WORRY:
		return SUCCESS
	
	return FAILURE
