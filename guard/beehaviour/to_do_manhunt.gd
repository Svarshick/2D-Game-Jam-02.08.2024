extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.state == actor.states.WORRY:
		return SUCCESS
	return FAILURE 
