extends ActionLeaf

var rotation_speed: float
var main_direction: Vector2
var checkpoint: Checkpoint

func before_run(actor: Node, blackboard: Blackboard):
	checkpoint = actor.checkpoints.current()
	rotation_speed =(
					2 * checkpoint.turn_angle * PI / 180 *
					checkpoint.turns_count / checkpoint.wait_time 
					)
	main_direction = actor.direction
	
	checkpoint.timer.start()


func tick(actor: Node, blackboard: Blackboard) -> int:
	if checkpoint.timer.is_stopped():
		return FAILURE
	
	var current_angle = main_direction.angle_to(actor.direction)
	if (abs(current_angle) > checkpoint.turn_angle * PI / 180):
		rotation_speed = -rotation_speed
	actor.direction = actor.direction.rotated(rotation_speed * get_process_delta_time())
	
	actor.set_animation("Idle")
	return RUNNING
