extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status == actor.statuses.SEE:
		return SUCCESS
	return FAILURE