extends Area2D

@onready var collision_shape_2d = $CollisionShape2D

func set_vision_radius(radius: float):
	collision_shape_2d.get_shape().radius = radius
