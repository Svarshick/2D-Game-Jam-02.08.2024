extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.state == actor.states.SEE:
		print("Chase begin")
		return SUCCESS
	return FAILURE 
