extends KinematicBody2D

var score = 0
var safety = 100

func on_body_entered(body):
	if body.is_in_group("partner"):
		print("hit partner!!!")
		body.emit_signal("partner_found")
		body.queue_free()
		return
		
	if body.is_in_group("falling"):
		
		match body.state:
			0:
				score += body.score * 1.2
				safety += 3
			1:
				score += body.score
				safety += 1
			2:
				if body.score > 0:
					score -= body.score
				safety -= 10
				
		if score < 0:
			score = 0
				
		if safety < 50:
			safety = 50
			
		if safety > 100:
			safety = 100

		body.queue_free()
		return
		
	if body.is_in_group("catastrophe"):
		score = 0
		safety = 50
		body.emit_signal("catastrophe_over")
		body.queue_free()
