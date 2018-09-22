extends Control

const HEIGHT = 7

var strength = 100
var Strength setget set_strength, get_strength

func set_strength(value):
	strength = value
	update()
	
func get_strength():
	return strength

func _draw():
	var rect = Rect2(-strength, -HEIGHT, strength * 2, HEIGHT * 2)
	draw_rect(rect, Color(0, 0.4, 0))