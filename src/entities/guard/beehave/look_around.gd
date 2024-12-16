extends ActionLeaf

var turn_times = 2
var turn_angle = 60
var turns_count = 4
var wait_time = 4
var rotation_speed
var main_direction
var timer

func before_run(actor: Node, blackboard: Blackboard):
	rotation_speed =(
					2 * turn_angle * PI / 180 *
					turns_count / wait_time 
					)
	main_direction = actor.direction
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = wait_time
	timer.one_shot = true
	timer.start()

func tick(actor: Node, blackboard: Blackboard) -> int:
	if timer.is_stopped():
		return SUCCESS
	
	var current_angle = main_direction.angle_to(actor.direction)
	if (abs(current_angle) > turn_angle * PI / 180):
		rotation_speed = -rotation_speed
	actor.direction = actor.direction.rotated(rotation_speed * get_process_delta_time())
	
	actor.set_animation("Idle")
	return RUNNING
	
