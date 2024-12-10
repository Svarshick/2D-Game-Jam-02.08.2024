extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	if blackboard.get_value("checkpoint timer timeout"):
		return SUCCESS
	return RUNNING
