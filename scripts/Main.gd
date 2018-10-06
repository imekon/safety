extends Node2D

const STARTING_Y = -50
const MOVEMENT = 100
const NUM_SHAPES = 17
const STATE_BIAS_CREEP = 0.02
const DISPLAY_DEBUGGING = false

var state_bias = 0
var doneCatastrophe = false
var pronoun
var preference
var religious_symbols = true

onready var scoreLabel = $ScoreLabel
onready var fpsLabel = $FPSLabel
onready var shapesLabel = $ShapesLabel
onready var safetyLabel = $SafetyLabel
onready var stateBiasLabel = $BiasLabel
onready var safeSpace = $SafeSpace
onready var player = $Player
onready var timer = $Timer

onready var beatStream = $AudioBeat
onready var melodyStream = $AudioMelody
onready var sfxStream = $AudioSFX

const Settings = preload("res://scripts/Settings.gd")

onready var fallingEuro = load("res://scenes/FallingEuro.tscn")
onready var fallingDollar = load("res://scenes/FallingDollar.tscn")
onready var fallingPound = load("res://scenes/FallingPound.tscn")
onready var fallingMale = load("res://scenes/FallingMale.tscn")
onready var fallingFemale = load("res://scenes/FallingFemale.tscn")
onready var fallingTrans = load("res://scenes/FallingTrans.tscn")
onready var fallingMusic = load("res://scenes/FallingMusic.tscn")
onready var fallingReligious = load("res://scenes/FallingReligious.tscn")
onready var fallingSkull = load("res://scenes/FallingSkull.tscn")

onready var partnerMale = load("res://scenes/FallingPartnerMale.tscn")
onready var partnerFemale = load("res://scenes/FallingPartnerFemale.tscn")
onready var partnerTrans = load("res://scenes/FallingPartnerTrans.tscn")

onready var directedCatastrophe = load("res://scenes/CatastropheShape.tscn")

onready var rain = load("res://scenes/Rain.tscn")

func _ready():
	randomize()
	var global = get_node("/root/global")
	pronoun = global.pronoun
	preference = global.preference
	religious_symbols = global.religious_symbols
	timer.start()
	
func _process(delta):
	scoreLabel.text = "Score: " + str(player.score)
	
	safeSpace.set_safety(player.safety)
	
	if DISPLAY_DEBUGGING:
		safetyLabel.text = "Safety: " + str(player.safety)
		var fps = Engine.get_frames_per_second()
		fpsLabel.text = "FPS: " + str(fps)
		shapesLabel.text = "Shapes: " + str(get_tree().get_nodes_in_group("falling").size())
	
		stateBiasLabel.text = "State Bias: " + str(state_bias)
	else:
		safetyLabel.hide()
		fpsLabel.hide()
		shapesLabel.hide()
		stateBiasLabel.hide()
	
	if state_bias < 0:
		state_bias += delta * STATE_BIAS_CREEP
		
	if state_bias > 0:
		state_bias -= delta * STATE_BIAS_CREEP
	
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
	elif picker > 0.99:
		release_the_partner()
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
	if !religious_symbols:
		return
	var item = fallingReligious.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
	
func release_the_skull():
	var item = fallingSkull.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	return item
	
func release_the_partner_male():
	print("male partner!")
	var item = partnerMale.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	item.connect("partner_found", self, "on_partner_found")
	return item
		
func release_the_partner_female():
	print("female partner!")
	var item = partnerFemale.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	item.connect("partner_found", self, "on_partner_found")
	return item
		
func release_the_partner_trans():
	print("trans partner!")
	var item = partnerTrans.instance()
	item.position = Vector2(get_random_start(), STARTING_Y)
	add_child(item)
	item.connect("partner_found", self, "on_partner_found")
	return item

func release_the_partner():
	match preference:
		Settings.MALE:
			release_the_partner_male()
		Settings.FEMALE:
			release_the_partner_female()
		Settings.OTHER:
			release_the_partner_trans()
		Settings.UNKNOWN:
			pass
		
func release_the_catastrophe():
	if doneCatastrophe:
		return
	var catastrophe = directedCatastrophe.instance()
	catastrophe.position = Vector2(get_random_start(), STARTING_Y)
	add_child(catastrophe)
	state_bias = 0.7
	catastrophe.connect("catastrophe_over", self, "on_catastrophe_over")
	doneCatastrophe = true
	
func on_catastrophe_over():
	state_bias = 0
	
func on_partner_found():
	state_bias = -0.7

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
		16:
			item = release_the_skull()
	if item == null:
		return
	item.state = state
	item.set_state()

# change the overall gravity, use 0.5 to SLOW it all down
func set_gravity(gravity):
	Physics2DServer.area_set_param(get_world_2d().get_space(), PhysicsServer.AREA_PARAM_GRAVITY_VECTOR, Vector2(0, gravity))

