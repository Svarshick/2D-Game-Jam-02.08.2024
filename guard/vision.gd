extends Feeling

@onready var navigation_agent_2d = $"../NavigationAgent2D" #rewrite
@onready var guard = $".."
@onready var collision_shape_2d = $CollisionShape2D

var angle: float
var range: float:
	set(value):
		range = value
		collision_shape_2d.get_shape().radius = value
		navigation_agent_2d.path_max_distance = value * 10

var player_in_range = false

func _ready():
	body_entered.connect(on_body_entered_vision)
	body_exited.connect(on_body_exited_vision)


func on_body_entered_vision(body):
	if body == guard.player:
		player_in_range = true


func on_body_exited_vision(body):
	if body == guard.player:
		player_in_range = false


func is_body_in_sector(body: Node) -> bool:
	var vecotor_to_body = body.position - guard.position
	var angle_to_body =  abs(vecotor_to_body.angle_to(guard.direction))
	return angle_to_body < (angle * PI / 360)

