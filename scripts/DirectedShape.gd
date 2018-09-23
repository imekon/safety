extends KinematicBody2D

const GRAVITY = 3

var velocity = Vector2(0, 0)

func _physics_process(delta):
	if position.y > 700:
		return
	velocity.y = velocity.y + delta * GRAVITY
	position.y = position.y + velocity.y

func on_timer_timeout():
	queue_free()
