extends ConditionLeaf

func tick(actor, blackboard) -> int: #expand
	if actor.status == actor.statuses.WORRY:
		return SUCCESS
	return FAILURE 
