extends ConditionLeaf


func tick(actor, _blackboard):
	var player = actor.player
	if (	
			actor.player_in_vision_range 
			and actor.is_body_in_vision_sector(player) 
			and actor.is_body_seen(player, 0x3)
		):
		actor.make_path(player.position)
		return SUCCESS
	return FAILURE
