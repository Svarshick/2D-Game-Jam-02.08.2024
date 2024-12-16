extends ActionLeaf

func tick(actor, blackboard):
	actor.seek_degree = 100
	blackboard.set_value("last player position", actor.player.global_position)
	return SUCCESS
