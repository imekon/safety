extends Sprite

const GRAVITY = 3

var velocity = 0

func _process(delta):
	if position.y > 700:
		queue_free()
		return
	velocity = velocity + delta * GRAVITY
	position.y = position.y + velocity
