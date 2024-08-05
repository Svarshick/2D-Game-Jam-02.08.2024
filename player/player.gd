extends CharacterBody2D

var speed = 200.0
@onready var animator = $AnimatedSprite2D


func _physics_process(delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	velocity = direction * speed
	set_animation(direction)
	move_and_collide(velocity * delta)


func set_animation(direction: Vector2):
	if direction != Vector2(0,0):
		if direction.x != 0:
			animator.flip_h = direction.x < 0
		animator.play("Run")
	else:
		animator.play("Idle")
