extends CharacterBody2D

class_name Guard

var config_stats = ConfigFile.new()
var err = config_stats.load("res://resources/stats.cfg")

#to_resource
var walk_speed: float
var run_speed: float: 
	set(value):
		run_speed = value
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

var statuses : Dictionary = {
	"DEFAULT": config_stats.get_value("guard", "default_status"),
	"WORRY": config_stats.get_value("guard", "worry_status"),
	"SEE": config_stats.get_value("guard", "see_status"),
}

var default_seek_increment = config_stats.get_value("guard", "default_seek_increment")
var default_seek_decrement = config_stats.get_value("guard", "default_seek_decrement")
var on_notice_seek_increment = config_stats.get_value("guard", "on_notice_seek_increment")
var on_notice_seek_decrement = config_stats.get_value("guard", "on_notice_seek_decrement")

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
var current_speed: float

@export var direction = Vector2(0, 0)

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
		
	if (direction == Vector2(0, 0)):
		direction = config_stats.get_value("guard", "direction")
	direction = direction.normalized()
	walk_speed = config_stats.get_value("guard", "walk_speed")
	run_speed = config_stats.get_value("guard", "run_speed")
	vision_angle = config_stats.get_value("guard", "vision_angle")
	vision_range = config_stats.get_value("guard", "vision_range")
	intuition_range = config_stats.get_value("guard", "intuition_range")
	seek_degree = config_stats.get_value("guard", "seek_degree")
	player_was_noticed = false
	
	set_animation("Idle")


func get_parameter_names():
	return [
#			"walk_speed",
#			"run_speed",
#			"vision_angle", 
			"vision_range", 
			"intuition_range",
			"player_was_noticed",
			"default_seek_increment",
			"default_seek_decrement",
			"on_notice_seek_increment",
			"on_notice_seek_decrement"
			]


func enter_kill():
	visible = true
	vision.visible = false
	intuition.visible = false
	modulate = Color.BLACK


func make_path(to_position: Vector2) -> void:
	navigator.target_position = to_position


func move_along_path(delta: float) -> void:
	direction = to_local(navigator.get_next_path_position()).normalized()
	var intended_velocity = direction * current_speed
	navigator.set_velocity(intended_velocity)
	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity 


func is_illusion_right(illusion: Illusion):
	return true


func set_animation(state: String):
	if direction.x > 0.7:
		animator.play(state + "_right")
	elif direction.x < -0.7:
		animator.play(state + "_left")
	elif direction.y > 0:
		animator.play(state + "_down")
	else:
		animator.play(state + "_up")
