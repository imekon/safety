extends RigidBody2D

enum { POSITIVE, NEUTRAL, NEGATIVE }

export(int) var score = 10
export(int) var state = NEUTRAL

onready var sprite = $Sprite

func set_state():
	match state:
		POSITIVE:
			sprite.modulate = Color(0, 1, 0)
		NEGATIVE:
			sprite.modulate = Color(1, 0, 0)
			
func _physics_process(delta):
	var y = position.y
	if y > 800:
		queue_free()

func on_timer_timeout():
	queue_free()
