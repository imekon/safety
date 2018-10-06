extends PanelContainer

onready var scoreLabel = $Panel/ScoreLabel
onready var highScoreLabel = $Panel/HighScoreLabel

func _ready():
	var global = get_node("/root/global")
	scoreLabel.text = "Score: " + str(global.score)
	highScoreLabel.text = "High Score: " + str(global.high_score)

func on_OK_pressed():
	get_tree().quit()
