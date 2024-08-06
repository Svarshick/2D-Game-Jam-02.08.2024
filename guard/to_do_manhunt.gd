extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.current_state == actor.states.WORRY:
		return SUCCESS
	return FAILURE 
