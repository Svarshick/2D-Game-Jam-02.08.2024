extends Area2D
class_name Feeling


@export var feeling_mask: int

#retracing
func is_body_felt(body: Node, collision_mask: int) -> bool:
	var space_state = get_world_2d().get_direct_space_state()
	var query = PhysicsRayQueryParameters2D.create(global_position, body.global_position, collision_mask)
	var sight_check = space_state.intersect_ray(query)
	if sight_check.is_empty():
		return false
	return sight_check.collider.name == body.name
