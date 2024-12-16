extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard):
	if actor.status == actor.statuses.SEE:
		return SUCCESS
	return FAILURE
