extends Node2D

var score = 0
var doneCatastrophe = false

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var introPanel = $IntroductionPanel
onready var introText = $IntroductionPanel/RichTextLabel
onready var timer = $Timer

onready var fallingEuro = load("res://scenes/FallingEuro.tscn")
onready var directedCatastrophe = load("res://scenes/CatastropheShape.tscn")

func _ready():
	introText.add_text("Life is about taking risks\n")
	introText.add_text("You can stay safe...\n")
	introText.add_text("Or you can take a risk...\n")

func _process(delta):
	scoreLabel.text = "Score: " + str(score)
	var fps = Engine.get_frames_per_second()
	fpsLabel.text = "FPS: " + str(fps)

func on_start_pressed():
	introPanel.hide()
	timer.start()

func on_timer_timeout():
	# var euro = fallingEuro.instance()
	# euro.position = Vector2(320, 100)
	#add_child(euro)

	if not doneCatastrophe:
		var catastrophe = directedCatastrophe.instance()
		catastrophe.position = Vector2(320, 100)
		add_child(catastrophe)
		doneCatastrophe = true