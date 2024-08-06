extends ActionLeaf

func tick(actor, blackboard):
	actor.make_path(Vector2.ZERO)
	actor.move_along_path(get_physics_process_delta_time())
	print("DEFAULT")
	return SUCCESS
	
