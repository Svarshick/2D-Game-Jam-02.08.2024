extends Feeling

@onready var navigator = $"../Navigator" #rewrite
@onready var guard = $".."
@onready var collision_shape_2d = $CollisionShape2D

var mask = 0b10111
var angle: float
var range: float:
	set(value):
		range = value
		collision_shape_2d.get_shape().radius = value
		navigator.path_max_distance = value * 10

var player_in_range = false


func _ready():
	body_entered.connect(on_body_entered_vision)
	body_exited.connect(on_body_exited_vision)


func _process(delta):
	queue_redraw()


func _draw():
	draw_vision_sector(Vector2.ZERO, guard.direction, range, angle * PI / 180, 20, guard.status_color)


func on_body_entered_vision(body):
	if body == guard.player:
		player_in_range = true
	if body is Illusion:
		guard.illusions_stack.push_back(body)


func on_body_exited_vision(body):
	if body == guard.player:
		player_in_range = false


func is_body_in_sector(body: Node) -> bool:
	var vecotor_to_body = body.position - guard.position
	var angle_to_body =  abs(vecotor_to_body.angle_to(guard.direction))
	return angle_to_body < (angle * PI / 360)


func draw_vision_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int, color: Color):
	var current_point = (direction * length).rotated(-angle/2)
	var points = PackedVector2Array()
	points.resize(precision + 1)
	points.insert(0, point)
	var space_state = get_world_2d().get_direct_space_state()
	for i in range(1, precision):
		var query = PhysicsRayQueryParameters2D.create(global_position, global_position + current_point, collision_mask)
		var sight_check = space_state.intersect_ray(query)
		if not sight_check.is_empty():
			points.insert(i, sight_check.position - global_position)
		else:
			points.insert(i, current_point)
		current_point = current_point.rotated(angle / (precision - 1))
	draw_colored_polygon(points, color)
