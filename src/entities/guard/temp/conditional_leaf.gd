extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if (actor.status == actor.statuses.SEE):
		print("NOTICED")
		return SUCCESS
	return FAILURE
