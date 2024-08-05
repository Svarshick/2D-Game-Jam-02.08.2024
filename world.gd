extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var guard = $Guard
@onready var guardClass = load("res://guard/guard.tscn")

func get_player():
	return player

func _physics_process(delta):
	queue_redraw()


func _ready():
	#var new_guard = guardClass.instantiate()
	#add_child(new_guard)
	pass
