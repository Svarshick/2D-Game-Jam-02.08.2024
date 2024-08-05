extends CharacterBody2D

#to_resource
var speed = 50.0:
	set(value):
		speed = value
		navigation_agent_2d.max_speed = value
var vision_angle = 100.0
var visible_distance = 200.0:
	set(value):
		visible_distance = value
		vision_range.set_vision_radius(value)
		navigation_agent_2d.path_max_distance = value * 10

var player_in_vision_range = false
var player_was_noticed = false
enum states {
	DEFAULT,
	SEEK,
	SEE
}
var seek_degree = 0.0
var direction = Vector2.RIGHT

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animator = $AnimatedSprite2D
@onready var vision_range = $VisionRange
@onready var navigation_agent_2d = $NavigationAgent2D


func get_parameter_names():
	return ["speed", "vision_angle", "visible_distance"]


func _ready():
	vision_range.set_vision_radius(visible_distance)
	vision_range.body_entered.connect(on_body_entered_vision_range)
	vision_range.body_exited.connect(on_body_exited_vision_range)
	print("Name: " + str(name))
	print("collision layer: " + str(collision_layer) + ", collision_mask: " + str(collision_mask))
	print("avoidance layer: " + str(navigation_agent_2d.navigation_layers) + ", avoidance mask: " + str(navigation_agent_2d.avoidance_mask))


func on_body_entered_vision_range(body):
	if body == player:
		player_in_vision_range = true


func on_body_exited_vision_range(body):
	if body == player:
		player_in_vision_range = false


func is_body_in_vision_sector(body: Node) -> bool:
	var vecotor_to_body = body.position - position
	var angle_to_body =  abs(vecotor_to_body.angle_to(direction))
	return angle_to_body < (vision_angle * PI / 360)


func is_body_seen(body: Node, collision_mask: int) -> bool:
	var space_state = get_world_2d().get_direct_space_state()
	var query = PhysicsRayQueryParameters2D.create(position, player.position, collision_mask)
	var sight_check = space_state.intersect_ray(query)
	if sight_check.is_empty():
		return false
	return sight_check.collider.name == body.name


func make_path(to_position: Vector2) -> void:
	navigation_agent_2d.target_position = to_position


func move_along_path(delta: float) -> void:
	direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	var intended_velocity = direction * speed
	navigation_agent_2d.set_velocity(intended_velocity)
	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity 


func _process(delta):
	queue_redraw()


func _draw():
	draw_sector(Vector2.ZERO, direction, visible_distance, vision_angle * PI / 180, 20)


func draw_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int):
	var current_point = (direction * length).rotated(-angle/2)
	var points = PackedVector2Array([point, current_point])
	var counter = 1
	while (counter < precision):
		current_point = current_point.rotated(angle / (precision - 1))
		counter += 1
		points.push_back(current_point)
	draw_colored_polygon(points, Color(0, 255, 0, 0.3))
	


#func move_toward_position(to_position: Vector2, delta: float): useless cosde 
	#direction = Vector2(to_position - position).normalized()
	#velocity = direction * speed
	#move_and_collide(velocity * delta)



