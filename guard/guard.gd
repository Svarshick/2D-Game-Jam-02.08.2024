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

var direction = Vector2.RIGHT

var player_was_noticed = false
enum states {
	DEFAULT = 0,
	WORRY = 75,
	SEE = 100
}
var current_state = states.DEFAULT
var seek_degree = 0.0:
	set(value):
		if value < 0:
			value = 0
		if value > 100:
			value = 100
		seek_degree = value
		if  value < states.WORRY:
			current_state = states.DEFAULT
		elif value < states.SEE:
			current_state = states.WORRY
		else:
			current_state = states.SEE
			player_was_noticed = true

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animator = $AnimatedSprite2D
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var vision = $Vision
@onready var intuition = $Intuition


func get_parameter_names():
	return ["speed", "vision_angle", "vision_range"]


func _ready():
	speed = 50
	vision_angle = 100
	vision_range = 200
	intuition_range = 50


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
	draw_sector(Vector2.ZERO, direction, vision.range, vision.angle * PI / 180, 20, Color(0, 255, 0, 0.3))
	draw_circle(Vector2.ZERO, intuition.range,  Color(0, 0, 255, 0.3))

func draw_sector(point: Vector2, direction: Vector2, length: float, angle: float, precision: int, color: Color):
	var current_point = (direction * length).rotated(-angle/2)
	var points = PackedVector2Array([point, current_point])
	var counter = 1
	while (counter < precision):
		current_point = current_point.rotated(angle / (precision - 1))
		counter += 1
		points.push_back(current_point)
	draw_colored_polygon(points, color)
	


#func move_toward_position(to_position: Vector2, delta: float): useless cosde 
	#direction = Vector2(to_position - position).normalized()
	#velocity = direction * speed
	#move_and_collide(velocity * delta)



