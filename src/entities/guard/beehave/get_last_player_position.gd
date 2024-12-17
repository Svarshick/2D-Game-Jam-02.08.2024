extends ActionLeaf


func before_run(actor: Node, blackboard: Blackboard):
	actor.current_speed = actor.run_speed
	actor.make_path(blackboard.get_value("last player position"))



func tick(actor: Node, blackboard: Blackboard):	
	if actor.navigator.is_navigation_finished():
		return SUCCESS
	
	actor.move_along_path(get_process_delta_time())
	actor.set_animation("Move")
	return RUNNING
