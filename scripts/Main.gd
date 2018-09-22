extends Node2D

var score = 0

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var introText = $IntroductionPanel/RichTextLabel

func _ready():
	introText.add_text("Life is about taking risks\n")
	introText.add_text("You can stay safe...\n")
	introText.add_text("Or you can take a risk...\n")

func _process(delta):
	scoreLabel.text = "Score: " + str(score)
	var fps = Engine.get_frames_per_second()
	fpsLabel.text = "FPS: " + str(fps)

func on_start_pressed():
	pass # replace with function body
