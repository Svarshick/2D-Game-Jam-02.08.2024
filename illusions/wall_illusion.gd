extends Illusion

@onready var border = $Border
@onready var hitbox = $Hitbox


func _ready():
	border.vertices = PackedVector2Array([
			Vector2(-8,-8), 
			Vector2(8, -8), 
			Vector2(8,8), 
			Vector2(-8,8)
			])
