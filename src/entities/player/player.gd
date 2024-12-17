extends CharacterBody2D

class_name Player

var config_stats = ConfigFile.new()
var err = config_stats.load("res://resources/stats.cfg")

var speed: float
var old_direction: Vector2
var direction = Vector2.RIGHT
var default_collision_layer

@onready var animator = $AnimatedSprite2D
@onready var death_effect = $DeathEffect


func _ready():
	speed = config_stats.get_value("player", "speed")
	default_collision_layer = collision_layer


func _physics_process(delta):
	if direction != Vector2.ZERO:
		old_direction = direction
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	velocity = direction * speed
	move_and_slide()
	set_animation(direction)


func set_animation(direction: Vector2):
	if direction != Vector2(0,0):
		if direction.x > 0:
			animator.play("Move_right")
		elif direction.x < 0:
			animator.play("Move_left")
		elif direction.y > 0:
			animator.play("Move_down")
		else:
			animator.play("Move_up")
	else:
		if old_direction.x > 0:
			animator.play("Idle_right")
		elif old_direction.x < 0:
			animator.play("Idle_left")
		elif old_direction.y > 0:
			animator.play("Idle_down")
		else:
			animator.play("Idle_up")


#shit code
func handle_death(killer: CanvasItem):
	prepate_level()
	enter_death(killer)
	killer.enter_kill()
	
	await get_tree().create_timer(1.5).timeout
	get_tree().get_first_node_in_group("level").world_environment.environment.adjustment_brightness = 1
	get_tree().call_deferred("reload_current_scene")


func enter_death(killer: CanvasItem):
	set_physics_process(false)
	animator.process_mode = Node.PROCESS_MODE_DISABLED
	visible = true
	modulate = Color.BLACK
	if killer is Guard:
		$DeathEffect.direction = killer.direction
	$DeathEffect.emitting = true


func prepate_level(): #! before entities
	var level = get_tree().get_first_node_in_group("level")
	for child in level.get_children():
		if child is CanvasItem and child is not Player:
			child.visible = false
			child.call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	
	var environment: Environment = level.world_environment.environment
	environment.adjustment_brightness = 8
