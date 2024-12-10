extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.status == actor.statuses.SEE:
		print("БЕГУ БИТЬ ЕБАЛО")
		return RUNNING
	return FAILURE
