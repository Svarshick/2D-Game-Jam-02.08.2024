extends ConditionLeaf


func tick(actor, blackboard) -> int:
	var player = actor.player
	if (
			actor.intuition.player_in_range
			and actor.intuition.is_body_felt(player,player.collision_layer)
		):
		return SUCCESS
	return FAILURE
