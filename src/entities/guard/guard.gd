extends CharacterBody2D

class_name Guard

#to_resource
var speed: float: 
	set(value):
		speed = value
		navigator.max_speed = value
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

		if  value < statuses.WORRY:
			status = statuses.DEFAULT
			status_color.g = 1
			status_color.r = (value / statuses.WORRY)
		elif value < statuses.SEE:
			status = statuses.WORRY
			status_color.r = 1;
			status_color.g = (statuses.SEE - value) / (statuses.SEE - statuses.WORRY)
		else:
			status = statuses.SEE
			status_color.r = 1;
			status_color.g = 0;
			player_was_noticed = true

		seek_degree = value

#unused
var illusions_stack: Array[Illusion]
var detected_illusions: Array[Illusion]
#because...

var status_color = Color(1, 0, 0, 0.2);
var checkpoints = Ring.new()

@export var direction = Vector2.RIGHT

@onready var player = get_tree().get_first_node_in_group("player")
@onready var navigator = $Navigator
@onready var vision = $Vision
@onready var intuition = $Intuition
@onready var beehave = $Beehave
@onready var animator = $AnimatedSprite2D
@onready var start_checkpoint = $StartCheckpoint


func _ready():
	#prepare checkpoints
	var children = get_children()
	for child in children:
		if child is Checkpoint:
			checkpoints.push_back(child)
	
	beehave.process_mode = Node.PROCESS_MODE_INHERIT
	# NavigationServer2D.map_changed.connect(beehave_on)
	direction = direction.normalized()
	
	speed = 50
	vision_angle = 100
	vision_range = 200
	intuition_range = 50
	seek_degree = 0.0
	player_was_noticed = false
	
	set_animation("Idle")


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
	navigator.target_position = to_position


func move_along_path(delta: float) -> void:
	direction = to_local(navigator.get_next_path_position()).normalized()
	var intended_velocity = direction * speed
	navigator.set_velocity(intended_velocity)
	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity 


func is_illusion_right(illusion: Illusion):
	return true


func _process(delta):
	queue_redraw()


func set_animation(state: String):
	if direction.x > 0.1:
		animator.play(state + "_right")
	elif direction.x < -0.1:
		animator.play(state + "_left")
	elif direction.y > 0:
		animator.play(state + "_down")
	else:
		animator.play(state + "_up")


func _draw():
	draw_vision_sector(Vector2.ZERO, direction, vision.range, vision.angle * PI / 180, 20, status_color)
	draw_circle(Vector2.ZERO, intuition_range, status_color)


func draw_vision_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int, color: Color):
	var current_point = (direction * length).rotated(-angle/2)
	var points = PackedVector2Array()
	points.resize(precision + 1)
	points.insert(0, point)
	var space_state = get_world_2d().get_direct_space_state()
	for i in range(1, precision):
		var query = PhysicsRayQueryParameters2D.create(global_position, global_position + current_point, vision.collision_mask)
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