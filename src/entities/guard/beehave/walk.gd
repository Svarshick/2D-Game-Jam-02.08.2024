extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if blackboard.get_value("target is reached"):
		return SUCCESS
	return RUNNING
