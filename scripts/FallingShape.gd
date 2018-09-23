extends RigidBody2D

enum { POSITIVE, NEUTRAL, NEGATIVE }

export(int) var score = 10
export(int) var state = NEUTRAL

func _ready():
	pass

func _physics_process(delta):
	var y = position.y
	if y > 800:
		queue_free()

func on_timer_timeout():
	queue_free()
