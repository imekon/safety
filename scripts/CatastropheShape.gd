extends "res://scripts/DirectedShape.gd"

onready var sprite = $Sprite
onready var tween = $Tween

func _ready():
	pulsate()

func _physics_process(delta):
	pass
	
func pulsate():
	while true:
		tween.interpolate_method(self, "on_pulsate", 1, 0.3, 2, Tween.TRANS_QUAD, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_completed")
		tween.interpolate_method(self, "on_pulsate", 0.3, 1, 2, Tween.TRANS_QUAD, Tween.EASE_IN)
		tween.start()
		yield(tween, "tween_completed")

func on_pulsate(value):
	sprite.modulate = Color(value, 0.5, 0.5)