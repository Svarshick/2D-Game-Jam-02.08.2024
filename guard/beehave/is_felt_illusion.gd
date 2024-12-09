extends ConditionLeaf


func is_illusion_detected(actor: Node, Nodeillusion: Illusion) -> bool:
	return true

func tick(actor, blackboard) -> int:
	for illusion in actor.illusions_stack:
		if is_illusion_detected(actor, illusion):
			actor.detected_illusions.push_back(illusion)
	return SUCCESS
	
