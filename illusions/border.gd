extends NavigationObstacle2D


func _ready():
	vertices = PackedVector2Array([
			Vector2(-8,-8), 
			Vector2(8, -8), 
			Vector2(8,8), 
			Vector2(-8,8)
			])
