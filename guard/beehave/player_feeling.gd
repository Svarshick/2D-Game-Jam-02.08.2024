extends ConditionLeaf


func tick(actor, blackboard) -> int:
	var player = actor.player
	if (
			actor.intuition.player_in_range
			and actor.intuition.is_body_felt(player, 0x3)
		):
		return SUCCESS
	return FAILURE
