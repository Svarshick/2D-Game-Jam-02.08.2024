extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if (actor.status == actor.statuses.SEE):
		print("I SEE YOU")
		return RUNNING
	return FAILURE
