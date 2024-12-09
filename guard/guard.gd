extends CharacterBody2D

#to_resource
var speed: float: 
	set(value):
		speed = value
		navigation_agent_2d.max_speed = value
var vision_angle: float:
	set(value):
		vision_angle = value
		vision.angle = value
var vision_range: float:
	set(value):
		vision_range = value
		vision.range = value
var intuition_range: float:
	set(value):
		intuition_range = value
		intuition.range = value 
#YOU HAVE TO REMAKE IT


enum statuses {
	DEFAULT = 0,
	WORRY = 75,
	SEE = 100
}

var default_seek_increment = 10
var default_seek_decrement = -2
var on_notice_seek_increment = 20
var on_notice_seek_decrement = -1
var player_was_noticed: bool:
	set(value):
		player_was_noticed = value
		if player_was_noticed:
			seek_increment = on_notice_seek_increment
			seek_decrement = on_notice_seek_decrement
		else:
			seek_increment = default_seek_increment
			seek_decrement = default_seek_decrement

var seek_increment
var seek_decrement
var status: int
var seek_degree: float:
	set(value):
		if value < 0:
			value = 0
		if value > 100:
			value = 100
		seek_degree = value
		if  value < statuses.WORRY:
			status = statuses.DEFAULT
			status_color.g = 1
			status_color.r = (value / statuses.WORRY)
		elif value < statuses.SEE:
			status = statuses.WORRY
			status_color.r = 1;
			status_color.g = (statuses.SEE - statuses.WORRY - value) / (statuses.SEE - statuses.WORRY)
		else:
			status = statuses.SEE
			status_color.r = 1;
			status_color.g = 0;
			player_was_noticed = true
#unused
var illusions_stack: Array[Illusion]
var detected_illusions: Array[Illusion]
#because...

var status_color = Color(1, 0, 0, 0.2);
var checkPoints: Array[Checkpoint]

@export var stay = true
@export var direction = Vector2.RIGHT
@export var default_walking: Array[Vector2] = [
		Vector2(0, 0),
		]
@onready var player = get_tree().get_first_node_in_group("player")
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var vision = $Vision
@onready var intuition = $Intuition


func _ready():
	var children = get_children()
	for child in children:
		if child is Checkpoint:
			checkPoints.push_back(child)
	for c in checkPoints:
		print("YES " + str(c.global_position))
	direction = direction.normalized()
	speed = 50
	vision_angle = 100
	vision_range = 200
	intuition_range = 50
	seek_degree = 0.0
	player_was_noticed = false
	navigation_agent_2d.on_reached_target()
	if default_walking.size() == 1:
		print(global_position)
		default_walking[0] == global_position



func get_parameter_names():
	return [
#			"speed",
#			"vision_angle", 
#			"vision_range", 
			"intuition_range",
			"player_was_noticed",
			"default_seek_increment",
			"default_seek_decrement",
			"on_notice_seek_increment",
			"on_notice_seek_decrement"
			]


func make_path(to_position: Vector2) -> void:
	navigation_agent_2d.target_position = to_position


func move_along_path(delta: float) -> void: #restarts if no point
	direction = to_local(navigation_agent_2d.get_next_path_position()).normalized()
	var intended_velocity = direction * speed
	navigation_agent_2d.set_velocity(intended_velocity)
	move_and_slide()


func hasTarget() -> bool:
	return navigation_agent_2d.get_next_path_position() == null


func restart_path() -> void:
	var nearest_walking_point = default_walking[0]
	var nearest_destination = default_walking[0].distance_to(global_position)
	var destination_to_point: int
	for i in range(1, default_walking.size() - 1):
		destination_to_point = default_walking[i].distance_to(global_position)
		if  destination_to_point < nearest_destination:
			nearest_destination = destination_to_point
			nearest_walking_point = default_walking[i]
	navigation_agent_2d.target_position = default_walking[0]



func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity 


func is_illusion_right(illusion: Illusion):
	return true


func _process(delta):
	queue_redraw()


func _draw():
	draw_vision_sector(Vector2.ZERO, direction, vision.range, vision.angle * PI / 180, 20, status_color)
	draw_circle(Vector2.ZERO, intuition.range,  status_color)


func draw_vision_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int, color: Color):
	var current_point = (direction * length).rotated(-angle/2)
	var points = PackedVector2Array()
	points.resize(precision + 1)
	points.insert(0, point)
	var space_state = get_world_2d().get_direct_space_state()
	for i in range(1, precision):
		var query = PhysicsRayQueryParameters2D.create(global_position, global_position + current_point, vision.mask)
		var sight_check = space_state.intersect_ray(query)
		if not sight_check.is_empty():
			points.insert(i, sight_check.position - global_position)
		else:
			points.insert(i, current_point)
		current_point = current_point.rotated(angle / (precision - 1))
	draw_colored_polygon(points, color)

#legacy

#func draw_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int, color: Color):
	#var current_point = (direction * length).rotated(-angle/2)
	#var points = PackedVector2Array([point, current_point])
	#var counter = 1
	#while (counter < precision):
		#current_point = current_point.rotated(angle / (precision - 1))
		#counter += 1
		#points.push_back(current_point)
	#draw_colored_polygon(points, color)


#func move_toward_position(to_position: Vector2, delta: float): useless cosde 
	#direction = Vector2(to_position - position).normalized()
	#velocity = direction * speed
	#move_and_collide(velocity * delta)
