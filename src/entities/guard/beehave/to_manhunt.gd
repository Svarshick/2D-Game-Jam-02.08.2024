extends ActionLeaf

var prediction_radius = 120

func before_run(actor: Node, blackboard: Blackboard):
	var last_player_position: Vector2 = blackboard.get_value("last player position")
	var map = actor.navigator.get_navigation_map()
	#IT NAVE TO BE REMAKED
	var predicted_position = NavigationServer2D.map_get_random_point(map, 1, true) #get_random_inside_circle(last_player_position, prediction_radius)
	while last_player_position.distance_to(predicted_position) > prediction_radius:
		predicted_position = NavigationServer2D.map_get_random_point(map, 1, true) #get_random_inside_circle(last_player_position, prediction_radius)
	#THANK YOU, GODOT
	actor.make_path(predicted_position)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor.navigator.is_target_reached():
		return SUCCESS
	
	actor.move_along_path(get_process_delta_time())
	actor.set_animation("Move")
	return RUNNING


#IT SHOULD BE INSTEAD OF SHIT ABOVE

#func position_is_reachable(position: Vector2, actor: Node) -> bool:
	#for region_rid in NavigationServer2D.map_get_regions(actor.navigator.get_navigation_map()):
			##PLEASE, LET ME ACCESS REGIONS POLYGON BY RID
	#return false


#func get_random_inside_circle(position: Vector2, radius: float) -> Vector2:
	#var randomiser = RandomNumberGenerator.new()
	#var random_radius = randomiser.randf_range(0, radius)
	#var random_direction = Vector2(random_radius, 0)
	#var random_angle = randomiser.randf_range(-PI, PI)
	#random_direction = random_direction.rotated(random_angle)
	#return random_direction + position
