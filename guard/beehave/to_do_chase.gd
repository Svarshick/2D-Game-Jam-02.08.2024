extends ConditionLeaf

func tick(actor, blackboard) -> int: #expand
	if actor.status == actor.statuses.SEE:
		print("Chase begin")
		return SUCCESS
	return FAILURE 
