extends KinematicBody2D

var score = 0

func on_body_entered(body):
	if body.is_in_group("falling"):
		match body.state:
			0:
				score += body.score * 1.5
			1:
				score += body.score
			2:
				score -= body.score
				
		body.queue_free()
