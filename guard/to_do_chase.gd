extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.current_state == actor.states.SEE:
		return SUCCESS
	return FAILURE 
