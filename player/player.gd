extends CharacterBody2D

var speed = 200.0
var old_direction: Vector2
var direction = Vector2.RIGHT
@onready var animator = $AnimatedSprite2D


func _physics_process(delta):
	if direction != Vector2.ZERO:
		old_direction = direction
	direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	velocity = direction * speed
	set_animation(direction)
	move_and_collide(velocity * delta)


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
		
