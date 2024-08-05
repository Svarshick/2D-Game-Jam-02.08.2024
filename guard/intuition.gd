extends Feeling

@onready var collision_shape_2d = $CollisionShape2D
@onready var guard = $".."

var range: float:
	set(value):
		range = value
		collision_shape_2d.get_shape().radius = value

var player_in_range = false

func _ready():
	body_entered.connect(on_body_entered_intuition)
	body_exited.connect(on_body_exited_intuition)


func on_body_entered_intuition(body):
	if body == guard.player:
		player_in_range = true


func on_body_exited_intuition(body):
	if body == guard.player:
		player_in_range = false
