extends Node2D

const MOVEMENT = 100
const NUM_SHAPES = 5

var score = 0
var doneCatastrophe = false

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var shapesLabel = $ShapesLabel
onready var player = $Player
onready var timer = $Timer

onready var fallingEuro = load("res://scenes/FallingEuro.tscn")
onready var fallingDollar = load("res://scenes/FallingDollar.tscn")
onready var fallingPound = load("res://scenes/FallingPound.tscn")
onready var fallingMale = load("res://scenes/FallingMale.tscn")
onready var fallingFemale = load("res://scenes/FallingFemale.tscn")

onready var directedCatastrophe = load("res://scenes/CatastropheShape.tscn")

func _ready():
	randomize()
	timer.start()

func _process(delta):
	scoreLabel.text = "Score: " + str(score)
	var fps = Engine.get_frames_per_second()
	fpsLabel.text = "FPS: " + str(fps)
	shapesLabel.text = "Shapes: " + str(get_tree().get_nodes_in_group("falling").size())
	
	if Input.is_action_pressed("ui_left"):
		move_player_left(delta)
		
	if Input.is_action_pressed("ui_right"):
		move_player_right(delta)
		
func move_player_left(delta):
	player.translate(Vector2(-delta * MOVEMENT, 0))
	
func move_player_right(delta):
	player.translate(Vector2(delta * MOVEMENT, 0))

func on_timer_timeout():
	var picker = randf()
	if picker > 0.99:
		release_the_catastrophe()
	else:
		pick_everything_else(picker)
		
func get_random_start():
	return randi() % 640
	
func release_the_euro():
	var euro = fallingEuro.instance()
	euro.position = Vector2(get_random_start(), 100)
	add_child(euro)
	
func release_the_dollar():
	var item = fallingDollar.instance()
	item.position = Vector2(get_random_start(), 100)
	add_child(item)
		
func release_the_pound():
	var item = fallingPound.instance()
	item.position = Vector2(get_random_start(), 100)
	add_child(item)
	
func release_the_male():
	var item = fallingMale.instance()
	item.position = Vector2(get_random_start(), 100)
	add_child(item)
		
func release_the_female():
	var item = fallingFemale.instance()
	item.position = Vector2(get_random_start(), 100)
	add_child(item)
		
func release_the_catastrophe():
	if doneCatastrophe:
		return
	var catastrophe = directedCatastrophe.instance()
	catastrophe.position = Vector2(get_random_start(), 100)
	add_child(catastrophe)
	doneCatastrophe = true

func pick_everything_else(picker):
	var index = int(picker * NUM_SHAPES)
	match index:
		0:
			release_the_euro()
		1:
			release_the_pound()
		2:
			release_the_dollar()
		3:
			release_the_male()
		4:
			release_the_female()