extends ConditionLeaf

func tick(actor, blackboard): #expand
	if actor.status == actor.statuses.SEE:
		print("Chase begin")
		return SUCCESS
	return FAILURE 
