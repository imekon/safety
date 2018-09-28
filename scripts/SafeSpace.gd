extends Node2D

onready var leftBody = $KinematicBodyLeft
onready var rightBody = $KinematicBodyRight

var safety = 100

func set_safety(value):
	if value > 100:
		return
		
	if value < 50:
		return

	leftBody.translate(Vector2(safety - value, 0))
	rightBody.translate(Vector2(value - safety, 0))
	
	safety = value
