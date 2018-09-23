extends RigidBody2D

func _ready():
	pass

func _physics_process(delta):
	var y = position.y
	if y > 800:
		queue_free()

func on_timer_timeout():
	queue_free()
