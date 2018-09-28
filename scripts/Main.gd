extends Node2D

const STARTING_Y = -50
const MOVEMENT = 100
const NUM_SHAPES = 16

var state_bias = 0
var doneCatastrophe = false

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var shapesLabel = $ShapesLabel
onready var safetyLabel = $SafetyLabel
onready var safeSpace = $SafeSpace
onready var player = $Player
onready var timer = $Timer

onready var fallingEuro = load("res://scenes/FallingEuro.tscn")
onready var fallingDollar = load("res://scenes/FallingDollar.tscn")
onready var fallingPound = load("res://scenes/FallingPound.tscn")
onready var fallingMale = load("res://scenes/FallingMale.tscn")
onready var fallingFemale = load("res://scenes/FallingFemale.tscn")
onready var fallingTrans = load("res://scenes/FallingTrans.tscn")
onready var fallingMusic = load("res://scenes/FallingMusic.tscn")
onready var fallingReligious = load("res://scenes/FallingReligious.tscn")

onready var directedCatastrophe = load("res://scenes/CatastropheShape.tscn")

onready var rain = load("res://scenes/Rain.tscn")

func _ready():
	randomize()
	timer.start()
	
func _process(delta):
	scoreLabel.text = "Score: " + str(player.score)
	safetyLabel.text = "Safety: " + str(player.safety)
	
	safeSpace.set_safety(player.safety)
	
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
	if picker > 0.999:
		release_the_catastrophe()
	else:
		var stateRange = randf() + state_bias
		var state = 1
		if stateRange < 0.2:
			state = 0
		elif stateRange > 0.8:
			state = 2
		pick_everything_else(picker, state)
	drop_rain()
	drop_rain()
	drop_rain()
	
func drop_rain():
	var drop = rain.instance()
	drop.position = Vector2(get_random_start(), STARTING_Y)
	add_child(drop)
		
func get_random_start():
	return randi() % 1280
	
func release_the_euro():
	var euro = fallingEuro.instance()
	euro.position = Vector2(get_random_start(), STARTING_Y)
	add_child(euro)
	return euro
	
func release_the_dollar():
	var item = fallingDollar.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
		
func release_the_pound():
	var item = fallingPound.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
	
func release_the_male():
	var item = fallingMale.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
		
func release_the_female():
	var item = fallingFemale.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
	
func release_the_trans():
	var item = fallingTrans.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
		
func release_the_music():
	var item = fallingMusic.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
		
func release_the_religious():
	var item = fallingReligious.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
		
func release_the_catastrophe():
	if doneCatastrophe:
		return
	var catastrophe = directedCatastrophe.instance()
	catastrophe.position = Vector2(get_random_start(), STARTING_Y)
	add_child(catastrophe)
	state_bias = 0.7
	connect("catastrophe_over", catastrophe, "on_catastrophe_over")
	doneCatastrophe = true
	
func on_catastrophe_over():
	state_bias = 0

func pick_everything_else(picker, state):
	var index = int(picker * NUM_SHAPES)
	var item = null
	match index:
		0:
			item = release_the_euro()
		1:
			item = release_the_pound()
		2, 3:
			item = release_the_dollar()
		4, 5, 6, 7, 8:
			item = release_the_male()
		9, 10, 11, 12:
			item = release_the_female()
		13:
			item = release_the_trans()
		14:
			item = release_the_music()
		15:
			item = release_the_religious()
	item.state = state
	item.set_state()

# change the overall gravity, use 0.5 to SLOW it all down
func set_gravity(gravity):
	Physics2DServer.area_set_param(get_world_2d().get_space(), PhysicsServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, gravity))

