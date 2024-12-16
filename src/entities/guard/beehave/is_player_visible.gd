extends ConditionLeaf

func tick(actor, blackboard):
	var player = actor.player
	if (
			actor.vision.player_in_range 
			and actor.vision.is_body_in_sector(player) 
			and actor.vision.is_body_felt(player)
	):
		return SUCCESS
	return FAILURE 
