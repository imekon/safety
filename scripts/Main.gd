extends Node2D

var score = 0
var doneCatastrophe = false

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var timer = $Timer

onready var fallingEuro = load("res://scenes/FallingEuro.tscn")
onready var directedCatastrophe = load("res://scenes/CatastropheShape.tscn")

func _ready():
	randomize()
	timer.start()

func _process(delta):
	scoreLabel.text = "Score: " + str(score)
	var fps = Engine.get_frames_per_second()
	fpsLabel.text = "FPS: " + str(fps)

func on_timer_timeout():
	# var euro = fallingEuro.instance()
	# euro.position = Vector2(320, 100)
	#add_child(euro)

	release_the_catastrophe()
		
func release_the_catastrophe():
	if doneCatastrophe:
		return
	var catastrophe = directedCatastrophe.instance()
	catastrophe.position = Vector2(randi() % 640, 100)
	add_child(catastrophe)
	doneCatastrophe = true
