extends Node2D

@onready var navigation_layer = $LayerHolder/Floor
@onready var world_environment = $WorldEnvironment


func _ready():
	await get_tree().create_timer(1).timeout # kind of synchronization with NavigationServer 
	for child in get_children():
		if child.is_in_group("guard"):
			child.process_mode = Node2D.PROCESS_MODE_INHERIT


func _physics_process(delta):
	queue_redraw()
