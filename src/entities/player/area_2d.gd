extends Area2D

var hideCounter = 0:
	set(value):
		if value == 0 and hideCounter > 0:
			player.collision_layer = player.default_collision_layer
			player.animator.modulate = Color.WHITE
		elif value > 0 and hideCounter == 0:
			player.collision_layer = 0b10_0000
			player.animator.modulate = Color.BLACK
		hideCounter = value

@onready var player = $"../"


func _on_body_entered(body: Node2D) -> void:
	if body is TileMapLayer:
		hideCounter += 1


func _on_body_exited(body: Node2D) -> void:
	if body is TileMapLayer:
		hideCounter -= 1
