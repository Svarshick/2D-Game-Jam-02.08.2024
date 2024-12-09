extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.status == actor.statuses.WORRY:
		return SUCCESS
	return FAILURE 
